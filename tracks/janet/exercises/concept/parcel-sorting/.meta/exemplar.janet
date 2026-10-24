(defn postage
  "(postage item) -> number of stamps for [:postcard], [:letter grams] or [:parcel grams]; nil for anything else"
  [item]
  (match item
    [:postcard] 1
    [:letter (g (<= g 20))] 1
    [:letter (g (<= g 100))] 2
    [:letter _] 4
    [:parcel grams] (+ 5 (div grams 1000))
    _ nil))

(defn route
  "(route address) -> string, where an address struct is sent"
  [address]
  (match address
    {:country "NL" :city city} (string "local: " city)
    {:country "BE"} "neighbour"
    {:country "DE"} "neighbour"
    {:country country} (string "abroad: " country)
    _ "return to sender"))

(defn sticker-text
  "(sticker-text sticker) -> string printed on a [:fragile & items], [:keep-cold degrees] or [:this-side-up] sticker"
  [sticker]
  (match sticker
    ([:fragile & items] (empty? items)) "Fragile"
    [:fragile & items] (string "Fragile: " (string/join items ", "))
    [:keep-cold (d (< d 0))] "Keep frozen"
    [:keep-cold d] (string "Keep below " d " degrees")
    [:this-side-up] "This side up"))

(defn for-depot?
  "(for-depot? parcel city) -> true when the parcel's :to address is in city, otherwise false"
  [parcel city]
  (match parcel
    {:to {:city (@ city)}} true
    _ false))
