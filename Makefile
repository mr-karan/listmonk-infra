.PHONY: scaffold
scaffold:
	kubekutr -c kubekutr.sample.yml scaffold -o .

.PHONY: build-base
build-base: scaffold
	kustomize build base

.PHONY: build-local
build-local: scaffold
	kustomize build overlays/local --load_restrictor none

.PHONY: deploy-local
deploy-local: build-local
	kubectl apply -f overlays/local/namespace.yml
	kustomize build overlays/local --load_restrictor none | microk8s.kubectl apply -f -
