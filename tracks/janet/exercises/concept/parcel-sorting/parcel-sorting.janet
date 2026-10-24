(defn postage
  "(postage item) -> number of stamps for [:postcard], [:letter grams] or [:parcel grams]; nil for anything else"
  [item]
  (error "implement me"))

(defn route
  "(route address) -> string, where an address struct is sent"
  [address]
  (error "implement me"))

(defn sticker-text
  "(sticker-text sticker) -> string printed on a [:fragile & items], [:keep-cold degrees] or [:this-side-up] sticker"
  [sticker]
  (error "implement me"))

(defn for-depot?
  "(for-depot? parcel city) -> true when the parcel's :to address is in city, otherwise false"
  [parcel city]
  (error "implement me"))
