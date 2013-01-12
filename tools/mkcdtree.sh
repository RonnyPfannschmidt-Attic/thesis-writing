mkdir -p thesis-cd
cd thesis-cd
cp ~/Projects/thesis/writing/document.pdf Pfannschmidt_CI.pdf
hg archive -R ~/Projects/thesis/evolve-proj evolve
hg archive -R ~/Projects/thesis/juggler juggler
