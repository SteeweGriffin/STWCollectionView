//
//  ViewController.swift
//  STWCollectionView
//
//  Created by Steewe MacBook Pro on 02/05/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit
import STWCollectionView

class ViewController: UIViewController {

    let cellIdentifier:String = "Cell"
    let collection = STWCollectionView()
    var dataCount:Int = 20
    var indexToSlide:Int = 10
    let labelScrollTo = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Collection"
        let settingBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(goToSettings))
        self.navigationItem.rightBarButtonItem = settingBarButtonItem

        self.collection.translatesAutoresizingMaskIntoConstraints = false
        self.collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.collection.delegate = self
        self.collection.dataSource = self
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        self.view.addSubview(self.collection)
        self.view.addSubview(stackView)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collection]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["collection":self.collection]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[stackView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["stackView":stackView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[collection]-20-[stackView]->=0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["collection":self.collection, "stackView":stackView]))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.collection, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))


        
        // SCROLL TO
        self.labelScrollTo.translatesAutoresizingMaskIntoConstraints = false
        self.labelScrollTo.text = "SCROLL TO: \(self.indexToSlide)"
        
        let buttonToScroll = UIButton(type: .system)
        buttonToScroll.translatesAutoresizingMaskIntoConstraints = false
        buttonToScroll.setTitle("GO", for: .normal)
        buttonToScroll.addTarget(self, action: #selector(scrollToPage), for: .touchUpInside)
        
        let slideScrollButton = UISlider()
        slideScrollButton.translatesAutoresizingMaskIntoConstraints = false
        slideScrollButton.minimumValue = 0.0
        slideScrollButton.maximumValue = Float(self.dataCount - 1)
        slideScrollButton.value = Float(self.indexToSlide)
        slideScrollButton.addTarget(self, action: #selector(ViewController.updateSlideTo(_:)), for: .valueChanged)
        
        let viewScrollTo = UIView()
        viewScrollTo.translatesAutoresizingMaskIntoConstraints = false
        
        viewScrollTo.addSubview(self.labelScrollTo)
        viewScrollTo.addSubview(slideScrollButton)
        viewScrollTo.addSubview(buttonToScroll)
        
        viewScrollTo.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["label":self.labelScrollTo]))
        viewScrollTo.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[slide]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["slide":slideScrollButton]))
        viewScrollTo.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[button]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["button":buttonToScroll]))
        viewScrollTo.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label]-[slide]-[button]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["label":self.labelScrollTo,"slide":slideScrollButton, "button":buttonToScroll]))
        
        stackView.addArrangedSubview(viewScrollTo)
        
        //VERTICAL LINE
        let lineV = UIView()
        lineV.translatesAutoresizingMaskIntoConstraints = false
        lineV.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        self.view.addSubview(lineV)
        
        self.view.addConstraint(NSLayoutConstraint(item: lineV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
        self.view.addConstraint(NSLayoutConstraint(item: lineV, attribute: .top, relatedBy: .equal, toItem: self.collection, attribute: .top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: lineV, attribute: .bottom, relatedBy: .equal, toItem: self.collection, attribute: .bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: lineV, attribute: .centerX, relatedBy: .equal, toItem: self.collection, attribute: .centerX, multiplier: 1, constant: 0))
        
        //HORIZONTAL LINE
        let lineH = UIView()
        lineH.translatesAutoresizingMaskIntoConstraints = false
        lineH.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        self.view.addSubview(lineH)
        
        self.view.addConstraint(NSLayoutConstraint(item: lineH, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1))
        self.view.addConstraint(NSLayoutConstraint(item: lineH, attribute: .left, relatedBy: .equal, toItem: self.collection, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: lineH, attribute: .right, relatedBy: .equal, toItem: self.collection, attribute: .right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: lineH, attribute: .centerY, relatedBy: .equal, toItem: self.collection, attribute: .centerY, multiplier: 1, constant: 0))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collection.scrollViewDidScroll(self.collection)
    }
    
    @objc func goToSettings(){
        let settings = SettingViewController(collection: self.collection)
        self.navigationController?.pushViewController(settings, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func scrollToPage(){
        let indexPath:IndexPath = IndexPath.init(item: self.indexToSlide, section: 0)
        self.collection.scrollTo(indexPath: indexPath, animated: true)
    }
    
    @objc func updateSlideTo(_ sender:UISlider){
        self.indexToSlide = Int(round(sender.value))
        self.labelScrollTo.text = "SCROLL TO: \(self.indexToSlide)"
    }
}

extension ViewController: STWCollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collection.scrollTo(indexPath: indexPath, animated: true)
    }
    
    func collectionViewDidEndDeceleratingWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths: [IndexPath], percentageVisibleIndexPaths percentages: [CGFloat]) {
        print("indexPaths after Decelerating: \(indexPaths)")
        print("percentages after Decelerating: \(percentages)")
    }
    
    func collectionViewDidEndScrollingAnimationWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths: [IndexPath], percentageVisibleIndexPaths percentages: [CGFloat]) {
        print("indexPaths after Scrolling Animation: \(indexPaths)")
        print("percentages after Scrolling Animation: \(percentages)")
    }
    
    func collectionViewDidScrollWithPercentages(_ collectionView: STWCollectionView, visibleIndexPaths indexPaths: [IndexPath], percentageVisibleIndexPaths percentages: [CGFloat]) {

        for i in 0..<indexPaths.count {
            
            if let cell = collectionView.cellForItem(at: indexPaths[i]) {
            
                let percentage = percentages[i]
            
                let value = 0.1 * percentage
            
                DispatchQueue.main.async {
                
                    switch collectionView.direction {
                    case .horizontal:
                    
                        cell.transform = CGAffineTransform.init(scaleX: 1, y: 1+value)
                    
                        break
                    case .vertical:
                    
                        cell.transform = CGAffineTransform.init(scaleX: 1+value, y: 1)
                    
                        break
                    }
                }

            }
            
            
        }
        
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.populate("-\(indexPath.row)-")
        
        return cell
    }
}

