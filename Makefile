COMMIT_HASH := $(shell eval git rev-parse HEAD)

doc:
	mkdocs build

livedoc: doc
	mkdocs serve --dirtyreload
