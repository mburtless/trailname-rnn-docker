# trailname-rnn-docker

## What's A Trail Name?

According to thru-hiking tradition, a trail name is the nickname, either chosen on one's own or given by a fellow hiker, that becomes the traveler's primary identiy during a trek.

I first found out about this after running into a few AT hikers while cycling the GAP trail.  I found the idea so rad that I was inspired to get a trail name of my very own.  However, since I don't have any cool thru-hiking buddies, I had no one to bestow me with one.  What's a lazy computer nerd/cyclist to do?

Enter the Recursive Neural Networks!  After scraping several sites, I generated a corpus of 10k plus trail names.  Using this, I was able to train the model provided by [torch rnn](https://github.com/jcjohnson/torch-rnn) to generate new trail names on demand.

This Docker image extends the torch rnn [Docker image](https://github.com/crisbal/docker-torch-rnn) and contains my model, as well as [OpenResty](https://openresty.org/en/) to provide an API.

## Getting Started

To pull from Docker Hub:
```
docker pull mburtless\trailname-rnn-docker
```

### Running

```
sudo docker run -p 6788:6788 mburtless\trailname-rnn-docker
```

You can then browse to ```http://localhost:6788``` to test the api.  Simply enter any start text and press submit to sample the model for some new trail names.

### Using the API

Submit JSON formated requests with one keyword named ```starttext``` and an arbitrary value via POST to ```http://localhost:6788``` The API will return a JSON formated response with a ```result``` keyword containing an array of dynamically genrated trail names.  Note that the exact number of returned trail names will vary, but will always total to 100 characters.

