{:user {:plugins [[venantius/ultra "0.5.2"
                   :exclusions [org.clojure/clojure]]
                  [lein-cljfmt "0.5.7"
                   :exclusions [org.clojure/clojure]]
                  [jonase/eastwood "0.2.5"
                   :exclusions [org.clojure/clojure]]]
        :repl-options {:init (require 'cljfmt.core)}
        :dependencies [[org.clojure/tools.nrepl "0.2.12"
                        :exclusions [org.clojure/clojure]]
                       [lein-cljfmt "0.5.7"
                        :exclusions [org.clojure/clojure]]
                       [jonase/eastwood "0.2.5"
                        :exclusions [org.clojure/clojure]]
                       [criterium "0.4.4"
                        :exclusions [org.clojure/clojure]]]}}
