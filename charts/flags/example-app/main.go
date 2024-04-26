package main

import (
	"context"
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
	flagd "github.com/open-feature/go-sdk-contrib/providers/flagd/pkg"
	"github.com/open-feature/go-sdk/openfeature"
)

func main() {
	r := mux.NewRouter()
	featureProvider := flagd.NewProvider(
		flagd.WithInProcessResolver(),
		flagd.WithHost("localhost"),
		flagd.WithPort(8013),
	)
	openfeature.SetProvider(featureProvider)
	of_client := openfeature.NewClient("example-app")

	r.HandleFunc("/flags/{id}", func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		id := vars["id"]

		evalCtx := openfeature.NewEvaluationContext(
			"",
			map[string]interface{}{
				"id": id,
			},
		)

		barValue, err := of_client.BooleanValue(context.Background(), "bar", false, evalCtx)

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		bazValue, err := of_client.BooleanValue(context.Background(), "baz", false, evalCtx)

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		fooValue, err := of_client.BooleanValue(context.Background(), "foo", false, evalCtx)

		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		values := map[string]bool{
			"bar": barValue,
			"baz": bazValue,
			"foo": fooValue,
		}

		jsonValues, err := json.Marshal(values)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(jsonValues)
	})

	http.ListenAndServe(":8080", r)
}
