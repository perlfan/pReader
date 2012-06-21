use LWP::Simple;


foreach(1..200){
    get('http://www.sina.com.cn');
    print "get sina $_ times ok \n";
}
