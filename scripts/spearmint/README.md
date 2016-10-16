# Spearmint

[Spearmint on GitHub](https://github.com/HIPS/Spearmint)

# Install Spearmint

```sh
mkdir ~/src
cd ~/src
git clone https://github.com/HIPS/spearmint
pip install ./spearmint
brew install mongodb
pip install pymongo
pip install scipy
```

# Run MongoDB

```sh
mkdir -p ~/work/spearmint
cd ~/work/spearmint
mkdir mongodb
mongod --logpath mongodb/mongod.log --dbpath mongodb
```

# Run the example `simple`

Add the `max_finished_jobs` parameter to `src/spearmint/examples/simple/config.json`

```json
"max_finished_jobs": 10
```

Run Spearmint

```sh
python ~/src/spearmint/spearmint/main.py ~/src/spearmint/examples/simple
ls ~/src/spearmint/examples/simple/output
```
