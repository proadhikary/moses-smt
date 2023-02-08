while IFS= read -r line
do
   "/home/moses/mosesdecoder/bin/moses" -f "/home/moses/moses-models/enhi/en-hi/engine/model/moses.ini" "$line" >> pred.txt
done < "src.txt"
