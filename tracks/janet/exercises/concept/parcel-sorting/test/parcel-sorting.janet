(import test :as t)
(import ../parcel-sorting :as sol)

(t/deftest "1. a postcard"
  (t/assert-equal 1 (sol/postage [:postcard])))

(t/deftest "1. letters by weight"
  (t/assert-equal [1 1 2 2 4] (map sol/postage [[:letter 5] [:letter 20] [:letter 21] [:letter 100] [:letter 101]])))

(t/deftest "1. a light parcel"
  (t/assert-equal 5 (sol/postage [:parcel 800])))

(t/deftest "1. a heavy parcel"
  (t/assert-equal 7 (sol/postage [:parcel 2500])))

(t/deftest "1. something unknown"
  (t/assert-equal nil (sol/postage [:pallet 90000])))

(t/deftest "2. a local address"
  (t/assert-equal "local: Utrecht" (sol/route {:country "NL" :city "Utrecht" :street "Oudegracht 1"})))

(t/deftest "2. the neighbours"
  (t/assert-equal ["neighbour" "neighbour"] [(sol/route {:country "BE" :city "Gent"}) (sol/route {:country "DE" :city "Köln"})]))

(t/deftest "2. abroad"
  (t/assert-equal "abroad: FR" (sol/route {:country "FR" :city "Lyon"})))

(t/deftest "2. a Dutch address without a city goes abroad by its country"
  (t/assert-equal "abroad: NL" (sol/route {:country "NL"})))

(t/deftest "2. no country"
  (t/assert-equal "return to sender" (sol/route {:city "Atlantis"})))

(t/deftest "3. fragile, contents unknown"
  (t/assert-equal "Fragile" (sol/sticker-text [:fragile])))

(t/deftest "3. fragile with contents"
  (t/assert-equal "Fragile: glass, china" (sol/sticker-text [:fragile "glass" "china"])))

(t/deftest "3. keep frozen"
  (t/assert-equal "Keep frozen" (sol/sticker-text [:keep-cold -18])))

(t/deftest "3. keep cold"
  (t/assert-equal "Keep below 5 degrees" (sol/sticker-text [:keep-cold 5])))

(t/deftest "3. this side up"
  (t/assert-equal "This side up" (sol/sticker-text [:this-side-up])))

(t/deftest "4. a parcel for the depot"
  (t/assert-equal true (sol/for-depot? {:id 7 :to {:city "Delft" :country "NL"}} "Delft")))

(t/deftest "4. a parcel for another city"
  (t/assert-equal false (sol/for-depot? {:id 8 :to {:city "Gouda" :country "NL"}} "Delft")))

(t/deftest "4. a parcel without an address"
  (t/assert-equal false (sol/for-depot? {:id 9} "Delft")))

(t/deftest "4. an address without a city"
  (t/assert-equal false (sol/for-depot? {:id 10 :to {:country "NL"}} "Delft")))

(t/run)
