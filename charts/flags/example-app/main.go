package main

import (
	"context"
	"encoding/json"
	"flag"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	flagd "github.com/open-feature/go-sdk-contrib/providers/flagd/pkg"
	"github.com/open-feature/go-sdk/openfeature"
)

func main() {
	host := flag.String("host", "localhost", "the host to connect to")
	port := flag.Uint("port", 8013, "the port to connect to")
	flag.Parse()

	r := mux.NewRouter()
	featureProvider := flagd.NewProvider(
		flagd.WithHost(*host),
		flagd.WithPort(uint16(*port)),
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

		funValue, err := of_client.IntValue(context.Background(), "fun", 4, evalCtx)
		funMessage := "Feature `funn` exists"
		if err != nil {
			funMessage = err.Error()
		}

		fancyValue, err := of_client.IntValue(context.Background(), "fancy", 4, evalCtx)
		fancyMessage := "Feature `fancy` exists"
		if err != nil {
			funMessage = err.Error()
		}

		values := map[string]string{
			"bar":          strconv.FormatBool(barValue),
			"barMessage":   barMessage,
			"baz":          strconv.FormatBool(bazValue),
			"bazMessage":   bazMessage,
			"foo":          strconv.FormatBool(fooValue),
			"fooMessage":   fooMessage,
			"fun":          strconv.Itoa(int(funValue)),
			"funMessage":   funMessage,
			"fancy":        strconv.Itoa(int(fancyValue)),
			"fancyMessage": fancyMessage,
		}

		jsonValues, err := json.MarshalIndent(values, "", "    ")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(jsonValues)
	})

	http.ListenAndServe(":8080", r)
}
