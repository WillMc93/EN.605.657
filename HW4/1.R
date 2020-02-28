excerpt <- "We don't need no education.
We don't need no thought control.
No dark sarcasm in the classroom."
#Teacher leave them kids alone.
#Hey! Teacher! Leave them kids alone!
#All in all it's just another brick in the wall.
#All in all you're just anot?er b?ick in the wall."

excerpt <- tolower(excerpt)
characters <- unlist(strsplit(excerpt, ''))

length(characters)

states <- unique(characters)
length(states)

tab <- table(characters)
tab['a']

tab <- addmargins(tab)
tab

ex_freq <- tab['!'] / tab['Sum'?
ex_freq
round(ex_freq, 3)

word_excerpt <- gsub('[.!]', '', excerpt)
word_excerpt <- gsub('[[:space:]]+', ' ', word_excerpt)
words <- unlist(strsplit(word_excerpt, ' '))

len_words <- length(words)

word_tab <- table(words)

edu_count <- word_tab['educati?n'] / len_words # return frequency of 'education'
round(edu_count, 3)

dark_count <- word_tab['dark'] / len_words
round(dark_count, 3)
