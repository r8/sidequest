// node:http server: renders buildData() on every request, so the page is current after any `quest test`.
import { createServer, type Server } from 'node:http';
import { clearToolVersions } from '../core/toolversion.ts';
import { buildData } from './data.ts';
import { renderHtml } from './render.ts';

export function startServer(root: string, port: number, host = '127.0.0.1'): Promise<Server> {
  const server = createServer((req, res) => {
    let path: string;
    try {
      path = new URL(req.url ?? '/', 'http://localhost').pathname;
    } catch {
      // A request target such as `//[` is not a URL; answer it rather than let the throw end the server.
      res.writeHead(400, { 'content-type': 'text/plain' });
      res.end('bad request\n');
      return;
    }
    // Freshness depends on the resolved tool versions, which a `mise install` can change at any time.
    clearToolVersions();
    try {
      // The body is built before any header is written, so a failure building it can still answer 500.
      if (path === '/' || path === '/index.html') {
        const body = renderHtml(buildData(root));
        res.writeHead(200, { 'content-type': 'text/html; charset=utf-8', 'cache-control': 'no-store' });
        res.end(body);
      } else if (path === '/data.json') {
        const body = JSON.stringify(buildData(root), null, 2);
        res.writeHead(200, { 'content-type': 'application/json', 'cache-control': 'no-store' });
        res.end(body);
      } else {
        res.writeHead(404, { 'content-type': 'text/plain' });
        res.end('not found\n');
      }
    } catch (err) {
      res.writeHead(500, { 'content-type': 'text/plain; charset=utf-8' });
      res.end(`quest dashboard: ${(err as Error).message}\n`);
    }
  });
  return new Promise((resolve, reject) => {
    server.once('error', reject);
    server.listen(port, host, () => resolve(server));
  });
}
