package main

import (
	"context"
	b64 "encoding/base64"
	"encoding/json"
	"fmt"
	"os"
	"strings"
	"time"

	// informers "github.com/argoproj/argo-cd/pkg/client/informers/externalversions"

	// clientset_argo "github.com/argoproj/argo-cd/pkg/client/clientset/versioned"
	// informers_argo "github.com/argoproj/argo-cd/pkg/client/informers/externalversions"

	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	kubeinformers "k8s.io/client-go/informers"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/cache"
	"k8s.io/client-go/tools/clientcmd"
	"sigs.k8s.io/yaml"
)

// ArgoEksConfig is the base64 encoded "config" inlined in the argo secret format:
// ---
// apiVersion: v1
// data:
//
//	config: ZXlKCSJITkRiR2xsY...    // <- this
//	name: YXKuOdF...
//	server: aHR0cHM6...
//
// kind: Secret
type ArgoEksConfig struct {
	BearerToken     string          `json:"bearerToken"`
	TLSClientConfig TLSClientConfig `json:"tlsClientConfig"`
}

type TLSClientConfig struct {
	Insecure bool   `json:"insecure"`
	CaData   string `json:"caData"`
}

func boostrapOnePassword(connectTokenSecret *v1.Secret, opCredentialsSecret *v1.Secret, targetClusterName string, targetClusterKubeConfig []byte) error {
	// TODO: add telemetry

	// Connect to target cluster
	config, err := clientcmd.RESTConfigFromKubeConfig(targetClusterKubeConfig)
	if err != nil {
		return err
	}
	fmt.Printf("Succssfully parsed kubeconfig for target cluster (%s)\n", targetClusterName)
	fmt.Printf("Creating client for target cluster (%s)\n", targetClusterName)

	targetCluster, err := kubernetes.NewForConfig(config)
	if err != nil {
		return err
	}
	fmt.Printf("Successfully created client for target cluster (%s)\n", targetClusterName)

	// Check if 1password namespace exists on target cluster
	fmt.Printf("Checking if 1password namespace exists on target cluster (%s)\n", targetClusterName)
	_, err = targetCluster.CoreV1().Namespaces().Get(
		context.TODO(),
		"1password",
		metav1.GetOptions{},
	)

	if err != nil {
		fmt.Printf("1password namespace does not exist on target cluster (%s), creating it\n", targetClusterName)
		_, err = targetCluster.CoreV1().Namespaces().Create(
			context.TODO(),
			&v1.Namespace{
				ObjectMeta: metav1.ObjectMeta{
					Name: "1password",
				},
			}, metav1.CreateOptions{})
		if err != nil {
			return err
		}
	} else {
		fmt.Printf("1password namespace exists on target cluster (%s)\n", targetClusterName)
	}

	// Deploy 1password Connect Token
	fmt.Printf("Checking if 1password-token secret exists on target cluster (%s)\n", targetClusterName)
	_, err = targetCluster.CoreV1().Secrets("1password").Get(
		context.TODO(),
		"onepassword-token",
		metav1.GetOptions{},
	)
	if err != nil {
		fmt.Println(err)
		fmt.Printf("onepassword-token secret does not exist on target cluster (%s), creating it\n", targetClusterName)
		_, err = targetCluster.CoreV1().Secrets("1password").Create(
			context.TODO(),
			&v1.Secret{
				ObjectMeta: metav1.ObjectMeta{
					Name:      "onepassword-token",
					Namespace: "1password",
				},
				Data: map[string][]byte{
					"token": connectTokenSecret.Data["credential"],
				},
			},
			metav1.CreateOptions{})
		if err != nil {
			fmt.Println(err)
			fmt.Printf("failed to create onepassword-token on target cluster (%s)\n", targetClusterName)
			return err
		}
		fmt.Printf("successfully created onepassword-token on target cluster (%s)\n", targetClusterName)
	} else {
		fmt.Printf("onepassword-token secret exists on target cluster (%s), updating it\n", targetClusterName)
		_, err = targetCluster.CoreV1().Secrets("1password").Update(
			context.TODO(),
			&v1.Secret{
				ObjectMeta: metav1.ObjectMeta{
					Name:      "onepassword-token",
					Namespace: "1password",
				},
				Data: map[string][]byte{
					"token": connectTokenSecret.Data["credential"],
				},
			},
			metav1.UpdateOptions{})
		if err != nil {
			fmt.Println(err)
			fmt.Printf("failed to update onepassword-token on target cluster (%s)\n", targetClusterName)
			return err
		}
		fmt.Printf("successfully updated onepassword-token on target cluster (%s)\n", targetClusterName)
	}

	// Deploy 1password Connect Credentials
	fmt.Printf("Checking if op-credentials secret exists on target cluster (%s)\n", targetClusterName)
	_, err = targetCluster.CoreV1().Secrets("1password").Get(
		context.TODO(),
		"op-credentials",
		metav1.GetOptions{},
	)
	if err != nil {
		fmt.Println(err)
		fmt.Printf("op-credentials secret does not exist on target cluster (%s), creating it\n", targetClusterName)
		_, err = targetCluster.CoreV1().Secrets("1password").Create(
			context.TODO(),
			&v1.Secret{
				ObjectMeta: metav1.ObjectMeta{
					Name:      "op-credentials",
					Namespace: "1password",
				},
				Data: map[string][]byte{
					"1password-credentials.json": []byte(b64.StdEncoding.EncodeToString(opCredentialsSecret.Data["1password-credentials.json"])),
				},
			},
			metav1.CreateOptions{})
		if err != nil {
			fmt.Println(err)
			fmt.Printf("failed to create op-credentials on target cluster (%s)\n", targetClusterName)
			return err
		}
		fmt.Printf("successfully created op-credentials on target cluster (%s)\n", targetClusterName)

	} else {
		fmt.Printf("op-credentials secret exists on target cluster (%s), updating it\n", targetClusterName)
		_, err = targetCluster.CoreV1().Secrets("1password").Update(
			context.TODO(),
			&v1.Secret{
				ObjectMeta: metav1.ObjectMeta{
					Name:      "op-credentials",
					Namespace: "1password",
				},
				Data: map[string][]byte{
					"1password-credentials.json": []byte(b64.StdEncoding.EncodeToString(opCredentialsSecret.Data["1password-credentials.json"])),
				},
			},
			metav1.UpdateOptions{})
		if err != nil {
			fmt.Println(err)
			fmt.Printf("failed to update op-credentials on target cluster (%s)\n", targetClusterName)
			return err
		}
		fmt.Printf("successfully updated op-credentials on target cluster (%s)\n", targetClusterName)
	}
	return nil
}

func copySecret(new *v1.Secret, old *v1.Secret, connectTokenSecret *v1.Secret, opCredentialsSecret *v1.Secret) (*v1.Secret, error) {
	secret := new.DeepCopy()

	argoEksConfig := ArgoEksConfig{}
	var server string
	argoClusterName := namespace() + "-" + secret.Name

	// extract data from crossplane secret
	var data = secret.Data
	for k, v := range data {
		switch k {
		case "kubeconfig":
			var kubeConfig KubeConfig
			err := yaml.Unmarshal(v, &kubeConfig)
			if err != nil {
				fmt.Println(err)
				return nil, err
			}
			if len(kubeConfig.Users) > 0 {
				argoEksConfig.BearerToken = kubeConfig.Users[0].User.Token
			}
			err = boostrapOnePassword(connectTokenSecret, opCredentialsSecret, secret.Name, v)
			if err != nil {
				fmt.Println(err)
			}
		case "clusterCA":
			b64cert := b64.StdEncoding.EncodeToString(v)
			argoEksConfig.TLSClientConfig.CaData = b64cert
			argoEksConfig.TLSClientConfig.Insecure = false
		case "endpoint":
			server = string(v)
		}
	}
	argoEksConfigJSON, err := json.Marshal(argoEksConfig)
	if err != nil {
		return nil, err
	}

	// write kubernetes secret to argocd namespace
	// (so that argocd picks it up as a cluster)
	result := v1.Secret{
		TypeMeta: metav1.TypeMeta{
			Kind:       "Secret",
			APIVersion: "v1",
		},
		ObjectMeta: metav1.ObjectMeta{
			Name:      argoClusterName,
			Namespace: "argocd",
			Annotations: map[string]string{
				"managed-by": "argocd.argoproj.io",
			},
			Labels: map[string]string{
				"argocd.argoproj.io/secret-type": "cluster",
			},
		},
		Data: map[string][]byte{
			"config": []byte(argoEksConfigJSON),
			"name":   []byte(argoClusterName),
			"server": []byte(server),
		},
		Type: "Opaque",
	}

	if old != nil {
		result.Labels = old.Labels
	}

	return &result, nil
}

func main() {

	// connect to Kubernetes API
	kubeconfig := os.Getenv("KUBECONFIG")
	config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
	if err != nil {
		panic(err.Error())
	}

	// set api clients up
	// kubernetes core api
	clientsetCore, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err.Error())
	} else {
		fmt.Println("Connected to Kubernetes API")
	}

	// retrieve 1password Connect Token
	connectTokenSecret, err := clientsetCore.CoreV1().Secrets(namespace()).Get(context.Background(), "onepassword-token", metav1.GetOptions{})
	if err != nil {
		panic(err.Error())
	} else {
		fmt.Println("Found 1password-token secret")
		connectTokenSecret = connectTokenSecret.DeepCopy()
		connectTokenSecret.UID = ""
		connectTokenSecret.ResourceVersion = ""
		connectTokenSecret.Namespace = "1password"
	}

	// retrieve 1password Connect Credentials
	opCredentials, err := clientsetCore.CoreV1().Secrets(namespace()).Get(context.Background(), "op-credentials", metav1.GetOptions{})
	if err != nil {
		panic(err.Error())
	} else {
		fmt.Println("Found op-credentials secret")
		opCredentials = opCredentials.DeepCopy()
		opCredentials.UID = ""
		opCredentials.ResourceVersion = ""
		opCredentials.Namespace = "1password"
	}

	// listen for new secrets
	factory := kubeinformers.NewSharedInformerFactoryWithOptions(clientsetCore, 0, kubeinformers.WithNamespace(namespace()))
	informer := factory.Core().V1().Secrets().Informer()
	stopper := make(chan struct{})
	defer close(stopper)

	informer.AddEventHandler(cache.ResourceEventHandlerFuncs{
		AddFunc: func(new interface{}) {
			// get the secret
			var secret = new.(*v1.Secret).DeepCopy()

			// check if the owner is of Kind: ClusterAuth
			// to make sure it's a crossplane kubernetes secret
			for _, o := range secret.OwnerReferences {
				if o.Kind == "ClusterAuth" {
					// prepare argo config
					result, err := copySecret(secret, nil, connectTokenSecret, opCredentials)
					if err != nil {
						fmt.Println(err)
					}
					// secretOut, err := clientsetCore.CoreV1().Secrets("argocd").Create(&secret)
					context, cancel := context.WithTimeout(context.Background(), 20*time.Second)
					opts := metav1.CreateOptions{}
					defer cancel()
					secretOut, err := clientsetCore.CoreV1().Secrets("argocd").Create(context, result, opts)
					// secretOut, err := clientsetCore.CoreV1().Secrets("argocd").Create(&secret)
					if err != nil {
						fmt.Println(err)
					} else {
						fmt.Println("Added cluster", secretOut.GetName())
					}
				}
			}

		},
		UpdateFunc: func(old interface{}, new interface{}) {
			var newSecret = new.(*v1.Secret).DeepCopy()

			contextGet, cancelGet := context.WithTimeout(context.Background(), 20*time.Second)
			optsGet := metav1.GetOptions{}
			defer cancelGet()

			oldSecret, err := clientsetCore.CoreV1().Secrets("argocd").Get(contextGet, namespace()+"-"+newSecret.Name, optsGet)
			if err != nil {
				fmt.Println(err)
			}

			// check if the owner is of Kind: ClusterAuth
			// to make sure it's a crossplane kubernetes secret
			for _, o := range newSecret.OwnerReferences {
				if o.Kind == "ClusterAuth" {
					// prepare argo config
					result, err := copySecret(newSecret, oldSecret, connectTokenSecret, opCredentials)
					if err != nil {
						fmt.Println(err)
					}
					// secretOut, err := clientsetCore.CoreV1().Secrets("argocd").Create(&secret)
					contextUpdate, cancelUpdate := context.WithTimeout(context.Background(), 20*time.Second)
					opts := metav1.UpdateOptions{}
					defer cancelUpdate()
					secretOut, err := clientsetCore.CoreV1().Secrets("argocd").Update(contextUpdate, result, opts)
					// secretOut, err := clientsetCore.CoreV1().Secrets("argocd").Create(&secret)
					if err != nil {
						fmt.Println(err)
					} else {
						fmt.Println("Added cluster", secretOut.GetName())
					}
				}
			}
		},
		DeleteFunc: func(obj interface{}) {
			// get the secret
			var secret = obj.(*v1.Secret).DeepCopy()

			// check if the owner is of Kind: ClusterAuth
			// to make sure it's a crossplane kubernetes secret
			for _, o := range secret.OwnerReferences {
				if o.Kind == "ClusterAuth" {

					// prepare argo config
					clusterName := namespace() + "-" + secret.Name

					context, cancel := context.WithTimeout(context.Background(), 20*time.Second)
					opts := metav1.DeleteOptions{}
					defer cancel()
					err = clientsetCore.CoreV1().Secrets("argocd").Delete(context, clusterName, opts)
					if err != nil {
						fmt.Println(err)
					}
					fmt.Println("Deleted cluster", namespace()+"-"+clusterName)
				}
			}
		},
	})

	informer.Run(stopper)
}

// get current namespace
func namespace() string {
	// This way assumes you've set the POD_NAMESPACE environment variable using the downward API.
	// This check has to be done first for backwards compatibility with the way InClusterConfig was originally set up
	if ns, ok := os.LookupEnv("POD_NAMESPACE"); ok {
		return ns
	}

	// Fall back to the namespace associated with the service account token, if available
	if data, err := os.ReadFile("/var/run/secrets/kubernetes.io/serviceaccount/namespace"); err == nil {
		if ns := strings.TrimSpace(string(data)); len(ns) > 0 {
			return ns
		}
	}

	return "default"
}

// KubeConfig holds data from crossplane secret field "kubeconfig"
type KubeConfig struct {
	APIVersion string `json:"apiVersion"`
	Clusters   []struct {
		Cluster struct {
			CertificateAuthorityData string `json:"certificate-authority-data"`
			Server                   string `json:"server"`
		} `json:"cluster"`
		Name string `json:"name"`
	} `json:"clusters"`
	Contexts []struct {
		Context struct {
			Cluster string `json:"cluster"`
			User    string `json:"user"`
		} `json:"context"`
		Name string `json:"name"`
	} `json:"contexts"`
	CurrentContext string `json:"current-context"`
	Kind           string `json:"kind"`
	Preferences    struct {
	} `json:"preferences"`
	Users []struct {
		Name string `json:"name"`
		User struct {
			Token string `json:"token"`
		} `json:"user"`
	} `json:"users"`
}
