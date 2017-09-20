//
//  SettingViewController.swift
//  STWCollectionView
//
//  Created by Steewe MacBook Pro on 16/05/17.
//  Copyright © 2017 Steewe. All rights reserved.
//

import UIKit
import STWCollectionView

enum SettingItemType:String {
    
    case spacing = "Spacing"
    case hPadding = "H-Padding"
    case vPadding = "V-Padding"
    case fixedCellsNumber = "Fix-Cells"
    case fixedSizeWidth = "Fix-Width"
    case fixedSizeHeight = "Fix-Height"
    case forceCenterd = "Force Centered"
}

protocol SettingsDeleagte:class {
    func didChangeValue(item:SettingItemView)
}

extension String {
    
    func getCGFloat() -> CGFloat {
        guard let number = NumberFormatter().number(from: self) else { return 0.0 }
        return CGFloat(truncating: number)
    }

}

class SettingItemView: UIView {
    
    private let input = UITextField()
    private let switcher = UISwitch()
    weak var delegate: SettingsDeleagte?
    var type:SettingItemType?
    
    convenience init(type: SettingItemType) {
        self.init(frame: CGRect.zero)
        self.type = type
        self.translatesAutoresizingMaskIntoConstraints = false
        self.createUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createUI(){
        
        //Label
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = self.type?.rawValue
        self.addSubview(label)
        
        if self.type! == .forceCenterd {
            self.switcher.translatesAutoresizingMaskIntoConstraints = false
            self.switcher.addTarget(self, action: #selector(switcherDidChange(_:)), for: .valueChanged)
            self.addSubview(self.switcher)
            
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[switcher]->=0-[label]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["label":label,"switcher":self.switcher]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["label":label]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[switcher]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["switcher":self.switcher]))
        } else {
            //Input
            self.input.autocorrectionType = .no
            self.input.spellCheckingType = .no
            self.input.translatesAutoresizingMaskIntoConstraints = false
            self.input.keyboardType = .decimalPad
            self.input.keyboardAppearance = .dark
            self.input.layer.borderColor = UIColor.gray.cgColor
            self.input.layer.borderWidth = 1
            self.input.textAlignment = .center
            self.input.addTarget(self, action: #selector(inputDidChange(_:)), for: .editingChanged)
            self.addSubview(self.input)
            
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[input(>=100)]-[label]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["label":label,"input":self.input]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["label":label]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[input]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["input":self.input]))
        }

    }
    
    func updateValue(value:String) {
        //self.input.text = value
        self.input.placeholder = value
    }
    
    func updateValue(active:Bool) {
        //self.input.text = value
        self.switcher.setOn(active, animated: false)
    }
    
    @objc func inputDidChange(_ sender:UITextField) {
        self.delegate?.didChangeValue(item: self)
    }
    
    @objc func switcherDidChange(_ sender:UISwitch) {
        self.delegate?.didChangeValue(item: self)
    }
    
    func getValue() -> CGFloat {

        guard let placeholder = self.input.placeholder else { return 0.0 }
        guard let text = self.input.text else { return placeholder.getCGFloat() }
        guard !text.isEmpty else { return placeholder.getCGFloat() }
        return text.getCGFloat()
        
    }
    
    func getBoolValue() -> Bool {
        return self.switcher.isOn
    }
    
}


class SettingViewController: UIViewController, SettingsDeleagte {

    weak var collection: STWCollectionView?
    let stackView = UIStackView()
    var specificInView:UIView?
    
    convenience init(collection:STWCollectionView) {
        self.init()
        self.collection = collection
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        self.view.backgroundColor = .white
        self.createUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createUI() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(gesture)
        
        //StackView
        
        self.stackView.distribution = .equalSpacing
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.stackView)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[stackView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["stackView":self.stackView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[stackView]->=0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["stackView":self.stackView]))
        
        let labelGeneral = UILabel()
        labelGeneral.translatesAutoresizingMaskIntoConstraints = false
        labelGeneral.textAlignment = .center
        labelGeneral.backgroundColor = .lightGray
        labelGeneral.text = "General"
        self.stackView.addArrangedSubview(labelGeneral)
        
        //Segment Direction
        let segmentDirection = UISegmentedControl(items: ["Horizontal","Vertical"])
        segmentDirection.selectedSegmentIndex = (self.collection?.direction == .horizontal) ? 0 : 1
        segmentDirection.addTarget(self, action: #selector(segmentDirectionDidChange(_:)), for: .valueChanged)
        self.stackView.addArrangedSubview(segmentDirection)
        
        //Spacing Item
        let spacing = SettingItemView(type: .spacing)
        spacing.delegate = self
        spacing.updateValue(value: "\(String(describing: collection!.itemSpacing))")
        self.stackView.addArrangedSubview(spacing)
        
        let labelSpecifics = UILabel()
        labelSpecifics.translatesAutoresizingMaskIntoConstraints = false
        labelSpecifics.textAlignment = .center
        labelSpecifics.backgroundColor = .lightGray
        labelSpecifics.text = "Specifics"
        self.stackView.addArrangedSubview(labelSpecifics)
        
        //Segment Type
        let segmentType = UISegmentedControl(items: ["Fixed Cells","Fixed Size"])
        segmentType.selectedSegmentIndex = (self.collection?.fixedCellSize == nil) ? 0 : 1
        segmentType.addTarget(self, action: #selector(segmentTypeDidChange(_:)), for: .valueChanged)
        self.stackView.addArrangedSubview(segmentType)
        
        self.segmentTypeDidChange(segmentType)
    }
    
    func createColumnsSettings() {
        self.removeLastViewOnStack()
        
        let columnsStackView = UIStackView()
        columnsStackView.axis = .vertical
        columnsStackView.spacing = 10
        columnsStackView.distribution = .fillEqually
        columnsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(columnsStackView)
        
        let columnsItem = SettingItemView(type: .fixedCellsNumber)
        columnsItem.delegate = self
        columnsItem.updateValue(value: "\(String(describing: collection!.fixedCellsNumber))")
        
        let hPaddingItem = SettingItemView(type: .hPadding)
        hPaddingItem.delegate = self
        hPaddingItem.updateValue(value: "\(String(describing: collection!.horizontalPadding))")
        
        let vPaddingItem = SettingItemView(type: .vPadding)
        vPaddingItem.delegate = self
        vPaddingItem.updateValue(value: "\(String(describing: collection!.verticalPadding))")

        columnsStackView.addArrangedSubview(columnsItem)
        columnsStackView.addArrangedSubview(hPaddingItem)
        columnsStackView.addArrangedSubview(vPaddingItem)
        
        
        self.specificInView = columnsStackView
        
    }
    
    func createFixedSizeSettings() {
        self.removeLastViewOnStack()
        
        let fixedSizeStackView = UIStackView()
        fixedSizeStackView.axis = .vertical
        fixedSizeStackView.spacing = 10
        fixedSizeStackView.distribution = .fillEqually
        fixedSizeStackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(fixedSizeStackView)
        
        let widthItem = SettingItemView(type: .fixedSizeWidth)
        widthItem.delegate = self
        widthItem.updateValue(value: (self.collection?.fixedCellSize != nil) ? "\(String(describing: collection!.fixedCellSize!.width))" : "0")
        
        let heightItem = SettingItemView(type: .fixedSizeHeight)
        heightItem.delegate = self
        heightItem.updateValue(value: (self.collection?.fixedCellSize != nil) ? "\(String(describing: collection!.fixedCellSize!.height))" : "0")
        
        let paddingItem = SettingItemView(type: (self.collection?.direction == .horizontal) ? .hPadding : .vPadding)
        paddingItem.delegate = self
        let paddingValue = (self.collection?.direction == .horizontal) ? collection!.horizontalPadding : collection!.verticalPadding
        paddingItem.updateValue(value: "\(String(describing: paddingValue))")
        
        let forceCentered = SettingItemView(type: .forceCenterd)
        forceCentered.delegate = self
        forceCentered.updateValue(active: self.collection!.forceCentered)
        
        fixedSizeStackView.addArrangedSubview(widthItem)
        fixedSizeStackView.addArrangedSubview(heightItem)
        fixedSizeStackView.addArrangedSubview(paddingItem)
        fixedSizeStackView.addArrangedSubview(forceCentered)
        
        self.specificInView = fixedSizeStackView
    }
    
    func removeLastViewOnStack() {
        self.specificInView?.removeFromSuperview()
    }
    
    //Gesture
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    //Segment Direction change
    
    @objc func segmentDirectionDidChange(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.collection?.direction = .horizontal
            break
        case 1:
            self.collection?.direction = .vertical
            break
            
        default:
            break
        }
        
        if self.collection?.fixedCellSize != nil {
            self.createFixedSizeSettings()
        }
    }
    
    //Segment Type change
    
    @objc func segmentTypeDidChange(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            
            self.collection?.fixedCellSize = nil
            self.createColumnsSettings()
            
            break
        case 1:
            
            self.createFixedSizeSettings()
            
            break
            
        default:
            break
        }
    }

    
    //Settings Delegate
    
    func didChangeValue(item:SettingItemView){
        if let type = item.type {
            switch type {
            case .spacing:
                collection?.itemSpacing = item.getValue()
                break
                
            case .fixedCellsNumber:
                if item.getValue() <= 0 {
                    self.lunchAlertController(item)
                }else{
                    collection?.fixedCellsNumber = Int(item.getValue())
                }
                break
                
            case .vPadding:
                collection?.verticalPadding = item.getValue()
                break
                
            case .hPadding:
                collection?.horizontalPadding = item.getValue()
                break
                
            case .fixedSizeWidth:
                let heightValue = (self.collection?.fixedCellSize != nil) ?  self.collection?.fixedCellSize?.height : item.getValue()
                collection?.fixedCellSize = CGSize(width: item.getValue(), height: heightValue!)
                break
                
            case .fixedSizeHeight:
                let widthValue = (self.collection?.fixedCellSize != nil) ?  self.collection?.fixedCellSize?.width : item.getValue()
                collection?.fixedCellSize = CGSize(width: widthValue!, height: item.getValue())
                break
                
            case .forceCenterd:
                collection?.forceCentered = item.getBoolValue()
                break

            }
        }
    }
    
    //Alert Controller
    
    func lunchAlertController(_ item:SettingItemView){
        let alertController = UIAlertController(title: "Warning!", message: "fixedCellsNumber number not be less then 1", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            item.updateValue(value: "1")
        }
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
