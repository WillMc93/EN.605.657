won <- 0
lost <- 0

for(game in (1:1000)) 
{
  sequence <- ""
  while(substr(sequence, nchar(sequence)-2, nchar(sequence)) != "HHT" &&
        substr(sequence, nchar(sequence)-2, nchar(sequence)) != "THH")
    {
    sequence <- aste(sequence, sample(c("H","T"), 1), sep="")
    if (substr(sequence, nchar(sequence)-2, nchar(sequence)) == "HHT")
      lost <- lost + 1
    if (substr(sequence, nchar(sequence)-2, nchar(sequence)) == "THH")
      won <- won + 1
    }
}

won
lost
