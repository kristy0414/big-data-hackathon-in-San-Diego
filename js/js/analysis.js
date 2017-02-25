d3.queue()
  .defer(d3.csv, "/data/mood_disorders.csv")
  .defer(d3.csv, "/data/parks_filtered.csv")
  .await(analyze);

function analyze(error, mood_disorders, parks_filtered) {
  if(error) { console.log(error); }
  mood_disorders.forEach(function(mood, i) {
    var result = parks_filtered.filter(function(parks) {
        return parks.Geography === mood.Geography;
    });
    mood.Parks = (result[0] !== undefined) ? result[0].p_parkacc : 0;
  	mood.Parks = +mood.Parks;
  	mood.Age_Adjusted_Rate = +mood.Age_Adjusted_Rate;
 	if(mood.Parks == 0) {
 		mood_disorders.splice(i, 1);
 	}
  });
  var u = [];
  var v = [];
  console.log(mood_disorders);
  mood_disorders.forEach(function(mood) {
  	if(mood.Parks !== undefined) {
  		u.push(mood.Age_Adjusted_Rate);
  		v.push(mood.Parks);
  	}
  });
  console.log(u);
  console.log(v);
  Array.prototype.mult = function (b) {
    var s = Array(this.length);
    for (var ind = 0; ind < this.length; ind++)
    {
	if (typeof(b)=="number")
	{
	    s[ind] = this[ind]* b;
	}
	else
	{
	    s[ind] = this[ind]* b[ind];
	}
    }
    return s;
  };

  variance = function(u)
  {
    var n=u.length,alpha = (n/(n-1));
    var r =  (d3.mean(u.map(function(v) { return v*v;})) - Math.pow(d3.mean(u),2));
    return alpha*r;
  }
  standardise = function(u)
  {
    var m = d3.mean(u), s=Math.sqrt(variance(u));
    return u.map(function(v) { return (v-m)/s;});
  }
  corcoef = function(u,v)
  {
    var us = standardise(u),vs = standardise(v),n=u.length;
    return (1/(n-1))*d3.sum(us.mult(vs));
  }
  var parks_mood = corcoef(u,v);
  console.log(parks_mood);
}