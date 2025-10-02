# wth

a super simple cli tool that asks ai and gives short answers. built with v.

## building

install vlang from https://vlang.io/

```bash
make
```

## usage

first, make sure ollama is running:

```bash
ollama serve
```

then pull the model:

```bash
ollama pull llama3.2:1b
```

then run:

```bash
./wth is 3 feet in meters
```

you can skip the 'is' if you want, like:

```bash
./wth 3 feet in meters
```

## what it does

it sends your query to a local ai model via ollama and gives back a short answer with a brief explanation.
