package main

import (
	"context"
	"encoding/json"
	"net/http"
	"strconv"

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
		barMessage := "Feature `bar` exists"
		if err != nil {
			barMessage = err.Error()
		}

		bazValue, err := of_client.BooleanValue(context.Background(), "baz", false, evalCtx)
		bazMessage := "Feature `baz` exists"
		if err != nil {
			bazMessage = err.Error()
		}

		fooValue, err := of_client.BooleanValue(context.Background(), "foo", false, evalCtx)
		fooMessage := "Feature `foo` exists"
		if err != nil {
			fooMessage = err.Error()
		}

		values := map[string]string{
			"bar":        strconv.FormatBool(barValue),
			"barMessage": barMessage,
			"baz":        strconv.FormatBool(bazValue),
			"bazMessage": bazMessage,
			"foo":        strconv.FormatBool(fooValue),
			"fooMessage": fooMessage,
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
