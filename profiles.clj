{:user {:plugins [[venantius/ultra "0.5.1"]
                  [lein-cljfmt "0.5.6"]
                  [jonase/eastwood "0.2.3"]]
        :repl-options {:init (require 'cljfmt.core)}
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]
                       [lein-cljfmt "0.5.6"]
                       [jonase/eastwood "0.2.3"
                        :exclusions [org.clojure/clojure]]]}}
