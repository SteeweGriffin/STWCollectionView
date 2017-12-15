Pod::Spec.new do |s|

	s.name		   = "STWCollectionView"
	s.version	   = "0.1.2"
	s.summary      = "A swift UICollectionView with carousel effect."
    s.description  = <<-DESC
                   STWCollectionView is an UICollectionView sublcass easy to create and manage for a collection with carousel effect and is very simple to customize.
You can set how many columns are visible simultaneously or give a fixed size to cells, and the collection will set automatically the columns.
You can set the space between the cells and the vertical and horizontal padding than you can see a bit of the adjacent cells.
Further, STWCollectionView has a delegate to better manage cells during the scrolling phase such as: the cell's currently visible indexPaths and their percentage of positioning based on the center.
                   DESC
    s.ios.deployment_target = '9.0'
    
 	s.homepage 	   = "http://www.steewe.com"
	s.license 	   = { :type => "MIT" }
	
  	s.author 	   = { "Raffaele Cerullo" => "me@steewe.com" }
    s.social_media_url = "https://twitter.com/Steewitter"
    
    s.source 	   = { :git => "https://github.com/SteeweGriffin/STWCollectionView.git", :tag => s.version.to_s }
    
    s.source_files = "STWCollectionView/*.swift"
    s.requires_arc = true
    s.ios.deployment_target = '9.0'
end