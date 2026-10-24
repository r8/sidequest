# Instructions

The Whiskers & Wags animal shelter keeps a record of every animal it takes in.
Each animal's record is a table of its own details, but much of how an animal behaves depends on what kind of animal it is.
The volunteer who looks after the records, Noor, wants to model that with prototypes: one `Pet` prototype for what all animals share, and more specific prototypes for each kind.

## 1. Define the pet prototype

Define the table `Pet` with:

- `:legs`, the number of legs a pet has unless its kind says otherwise: 4;
- the method `:introduce`, which returns `"Hi, I'm "` followed by the pet's `:name` and `"!"`;
- the method `:speak`, which returns the pet's name followed by `" makes a happy noise"`.

```janet
(def biscuit (table/setproto @{:name "Biscuit"} Pet))
(:introduce biscuit)
# => "Hi, I'm Biscuit!"
(:speak biscuit)
# => "Biscuit makes a happy noise"
```

## 2. Define the kinds of pet

Define the tables `Dog` and `Bird`, both with `Pet` as their prototype:

- a dog's `:speak` returns its name followed by `" says woof"`;
- a bird has 2 `:legs`, and its `:speak` returns its name followed by `" says tweet"`.

```janet
(:speak (table/setproto @{:name "Rex"} Dog))
# => "Rex says woof"
((table/setproto @{:name "Kiwi"} Bird) :legs)
# => 2
```

## 3. Admit an animal

Define the function `admit` that takes a kind (a prototype such as `Dog`) and a name, and returns a new pet: a table with the `:name` and a `:meals` count of 0, whose prototype is the kind.

```janet
(def rex (admit Dog "Rex"))
(rex :meals)
# => 0
(:speak rex)
# => "Rex says woof"
```

## 4. Feed the animals

Add the method `:feed` to `Pet`.
It takes a number of meals, adds them to the pet's `:meals` count, and returns the pet, so that feedings can be chained.

```janet
(def rex (admit Dog "Rex"))
(:feed (:feed rex 1) 2)
(rex :meals)
# => 3
```

## 5. Check an animal's kind

Define the function `kind?` that takes a pet and a prototype, and returns `true` if the prototype is anywhere in the pet's chain of prototypes, `false` otherwise.

```janet
(kind? (admit Dog "Rex") Dog)
# => true
(kind? (admit Dog "Rex") Pet)
# => true
(kind? (admit Dog "Rex") Bird)
# => false
```
