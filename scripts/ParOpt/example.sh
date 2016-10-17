### recreate analysis with ParOpt ###

mkdir abyss
cd abyss
wget http://bit.ly/2eePq95
cd ../
git clone https://github.com/sseemayer/ParOpt.git

cd abyss

# optimize k through range [30-45]
../ParOpt/popt --grid max '../ParOpt/Abyss_wrapper.py {0}' 'fx = (.*)' 30,45,1
