(ns components.home
  (:require [reagent.core :as r]
            [reagent.dom :as dom]
            ))

(defn home []
  [:h1 "Change a little bit"])

(defn display [] (. js/document addEventListener "DOMContentLoaded"
  #(dom/render [home]
              (. js/document getElementById "root"))))

;; (def ^:export home-page (r/as-element [:h1 "This is it"]))


(defn ^:export echo-recv-message [msg]
  (. js/console log msg)
  (. js/console log "here...")

  )

