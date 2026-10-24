# A resident is named by nationality: :english, :spanish, :ukrainian, :norwegian or :japanese.

(defn- permutations [items]
  (if (empty? items)
    [[]]
    (mapcat (fn [x] (map |[x ;$] (permutations (filter |(not= x $) items))))
            items)))

(def- orders (permutations (range 5)))

(defn- next-to? [a b] (= 1 (math/abs (- a b))))

# Each binding is the house (0 to 4, left to right) of that color, resident, drink, hobby or pet.
# Checking each clue as soon as its attributes are bound prunes almost all of the 120^5 cases.
(def- solution
  (label found
    (each [red green ivory yellow blue] orders
      (when (= green (+ ivory 1))
        (each [english spanish ukrainian norwegian japanese] orders
          (when (and (= english red) (= norwegian 0) (next-to? norwegian blue))
            (each [coffee tea milk orange-juice water] orders
              (when (and (= coffee green) (= tea ukrainian) (= milk 2))
                (each [dancing painting reading football chess] orders
                  (when (and (= painting yellow) (= football orange-juice) (= chess japanese))
                    (each [dog snails fox horse zebra] orders
                      (when (and (= dog spanish) (= snails dancing)
                                 (next-to? reading fox) (next-to? painting horse))
                        (def resident {english :english spanish :spanish ukrainian :ukrainian
                                       norwegian :norwegian japanese :japanese})
                        (return found {:water (resident water) :zebra (resident zebra)})))))))))))))

(defn drinks-water
  "(drinks-water) -> the nationality of the resident who drinks water"
  []
  (solution :water))

(defn owns-zebra
  "(owns-zebra) -> the nationality of the resident who owns the zebra"
  []
  (solution :zebra))
