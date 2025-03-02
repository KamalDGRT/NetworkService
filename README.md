# NetworkService

A swift wrapper to do API calls using traditional `URLSession.dataTask`


### Credits & Licenses

I would like to sincerely thank this open-source project:

- [APIClient](https://github.com/Zhendryk/APIClient) - GPL-3.0 license

I stumbled across this project when I was exploring how other developers are creating the API layer. Zhendryk has implemented the APIRequest as a protocol, but I am using `struct` and have added my own style. I liked the way it was structured but I felt that Zhendryk's implementation was a little too big for my use-case. So, I have simplified and split most of the stuff in the network layer into its own functions.
