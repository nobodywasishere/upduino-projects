## hamming

A simple hamming(16,11) implementation

![](./hamming.jpg)

Was tested by connecting hamming_set, hamming_detect, and hamming_correct together, setting an input, and making sure it matched the output. No further testing has been done yet.

- hamming_set - Takes in 8 bits of data and gives a proper 16-bit hamming code.

![](./svg/hamming_set.svg)

- hamming_detect - Takes in a 16-bit hamming code and gives back either the error location (if there's one error) or if there was a double error (in which it will set error location to zero).

![](./svg/hamming_detect.svg)

- hamming_correct - Takes in a 16-bit hamming code and error location and corrects it, giving back the original 8 bits of data.

![](./svg/hamming_correct.svg)

Thank you to 3blue1brown and Ben Eater's videos on this topic, as they were the resources I used to implement this project:
- 3blue1brown: https://www.youtube.com/watch?v=X8jsijhllIA, https://www.youtube.com/watch?v=b3NxrZOu_CE
- Ben Eater: https://www.youtube.com/watch?v=h0jloehRKas
