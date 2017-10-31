//
//  AddressSelectView.swift
//  CZSwfitTest
//
//  Created by 程健 on 2017/10/27.
//  Copyright © 2017年 程健. All rights reserved.
//

import UIKit


private let kAddressSelectCellHeight: CGFloat = 45
private let kAddressContentViewWidth :CGFloat = UIScreen.main.bounds.size.width
private let kAddressContentViewHeight: CGFloat = 400
private let kAddressSelectTopTabbarHeight: CGFloat = 45
private let kAddressColorMotif: UIColor = UIColor.init(red: 246/255.0, green: 16/255.0, blue: 39/255.0, alpha: 1.0)
private let kAddressColorLine: UIColor = UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)

protocol AddressSelectTopTabbarDelegate {
    func topTabbar(_ topTabbar: AddressSelectTopTabbar, didSelectWithIndex index: Int)
    func didSelelctCancel(_ topTabbar: AddressSelectTopTabbar)
}

// MARK: - AddressSelectTopTabbar
class AddressSelectTopTabbar : UIView {
    var lineView: UIView = UIView.init()
    var dataSource: [AddressModel] = [AddressModel]()
    var delegate: AddressSelectTopTabbarDelegate?
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        let bottomLineView = UIView.init(frame: CGRect(x: 0, y: kAddressSelectTopTabbarHeight-0.5, width: kAddressContentViewWidth, height: 0.5))
        bottomLineView.backgroundColor = kAddressColorLine
        self.addSubview(bottomLineView)
        
        lineView.frame = CGRect(x: 0, y: kAddressSelectTopTabbarHeight-2, width: 40, height: 2)
        lineView.backgroundColor = kAddressColorMotif
        self.addSubview(lineView)
        
        let cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: kAddressContentViewWidth-50, y: 0, width: 50, height: kAddressSelectTopTabbarHeight)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.lightGray, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.tag = 888
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.addTarget(self, action:#selector(cancelAction(sender:)), for:.touchUpInside)
        self.addSubview(cancelButton)
        
        let left = 15.0
        let text = "请选择"
        let itemView = UIButton(type: .custom)
        itemView.frame = CGRect(x: kAddressContentViewWidth-50, y: 9, width: 50, height: kAddressSelectTopTabbarHeight)
        itemView.setTitle(text, for: .normal)
        itemView.setTitleColor(kAddressColorMotif, for: .normal)
        itemView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        itemView.tag = 100
        itemView.backgroundColor = UIColor.clear
        itemView.addTarget(self, action:#selector(itemAction(sender:)), for:.touchUpInside)
        self.addSubview(itemView)
        
        let size = text.size(withFont: itemView.titleLabel!.font, maxSize: CGSize(width: 90, height: 30))
        itemView.frame = CGRect(x: CGFloat(left), y: CGFloat(0), width: size.width, height: kAddressSelectTopTabbarHeight)
        
        lineView.left = itemView.left
        lineView.width = itemView.width
    }
    
    func addItem(withIndex index: Int, atAddress address: AddressModel)  {
        if dataSource.count > 0 {
            dataSource.removeLast(dataSource.count-index)
        }
        dataSource.append(address)
        
        for view in self.subviews {
            if view is UIButton && view.tag != 888 {
                view.removeFromSuperview()
            }
        }
        
        var left :CGFloat = 15
        
        for (i, model) in dataSource.enumerated() {
        
            let text = model.region_name!
            
            let itemView = UIButton(type: .custom)
            itemView.frame = CGRect(x: kAddressContentViewWidth-50, y: 9, width: 50, height: kAddressSelectTopTabbarHeight)
            itemView.setTitle(text, for: .normal)
            itemView.setTitleColor(kAddressColorMotif, for: .normal)
            itemView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            itemView.tag = 100 + i
            itemView.backgroundColor = UIColor.clear
            itemView.addTarget(self, action:#selector(itemAction(sender:)), for:.touchUpInside)
            self.addSubview(itemView)
            
            let size = text.size(withFont: itemView.titleLabel!.font, maxSize: CGSize(width: 90, height: 30))
            itemView.frame = CGRect(x: CGFloat(left), y: CGFloat(0), width: size.width, height: kAddressSelectTopTabbarHeight)
            left += (size.width+15)
        }
        
        if index < 2 {

            let text = "请选择"
            let itemView = UIButton(type: .custom)
            itemView.frame = CGRect(x: kAddressContentViewWidth-50, y: 9, width: 50, height: kAddressSelectTopTabbarHeight)
            itemView.setTitle(text, for: .normal)
            itemView.setTitleColor(kAddressColorMotif, for: .normal)
            itemView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            itemView.tag = 100 + index + 1
            itemView.backgroundColor = UIColor.clear
            itemView.addTarget(self, action:#selector(itemAction(sender:)), for:.touchUpInside)
            self.addSubview(itemView)
            
            let size = text.size(withFont: itemView.titleLabel!.font, maxSize: CGSize(width: 90, height: 30))
            itemView.frame = CGRect(x: CGFloat(left), y: CGFloat(0), width: size.width, height: kAddressSelectTopTabbarHeight)
            left += (size.width+15)
        }
        select(withIndex: index<2 ? index+1 : index)
    }
    
    func select(withIndex index: Int)  {
        let itemView: UIButton = self.viewWithTag(index+100) as! UIButton
        UIView.animate(withDuration: 0.25) {
            self.lineView.width = itemView.width
            self.lineView.left = itemView.left
        }
    }
    
    @objc private func itemAction(sender: UIButton) {
        select(withIndex: sender.tag - 100)
        guard let delegate = self.delegate else {
            return;
        }
        delegate.topTabbar(self, didSelectWithIndex: sender.tag - 100)
    }
    
    @objc private func cancelAction(sender : UIButton) {
        guard let delegate = self.delegate else {
            return;
        }
        delegate.didSelelctCancel(self)
    }
}


// MARK: - AddressSelectCell
class AddressSelectCell: UITableViewCell {
    
    var titleLabel: UILabel = UILabel.init()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    func isSelct(isSelect : Bool) {
        if isSelect {
            self.titleLabel.textColor = kAddressColorMotif
        }else{
            self.titleLabel.textColor = UIColor.black
        }
    }
    
    private func setupUI() {
        self.titleLabel = UILabel.init()
        self.titleLabel.backgroundColor = UIColor.clear;
        self.titleLabel.frame = CGRect(x:15, y:0, width:kAddressContentViewWidth-15*2, height:kAddressSelectCellHeight)
        self.titleLabel.text = "Title"
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.textAlignment = NSTextAlignment.left
        self.contentView.addSubview(self.titleLabel)
        
        let lineView = UIView.init(frame: CGRect(x: self.titleLabel.left, y: kAddressSelectCellHeight-0.5, width:kAddressContentViewWidth , height: 0.5))
        lineView.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        self.contentView.addSubview(lineView)
    }
}

typealias SelectBlock = (AddressModel,AddressModel,AddressModel) -> ()

// MARK: - AddressSelectView
class AddressSelectView: UIView {
    
    var backgroundView: UIView = UIView()
    var contentView: UIView = UIView()
    var scrollView: UIScrollView = UIScrollView()
    var topTabbar: AddressSelectTopTabbar = AddressSelectTopTabbar()
    
    var selectBlock: SelectBlock?
    var dataSource = AddressConfigManager.shared.addressDatas?.items
    var selectIndexs : [Int] = [Int]()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init () {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.clear
        
        backgroundView.frame = UIScreen.main.bounds
        backgroundView.alpha = 0
        backgroundView.backgroundColor = UIColor.black
        self.addSubview(backgroundView)
        
        contentView.frame = CGRect(x: 0, y: self.height, width: self.width, height: kAddressContentViewHeight)
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        
        topTabbar.frame = CGRect(x: 0, y: 0, width: contentView.width, height: kAddressSelectTopTabbarHeight)
        topTabbar.delegate = self
        contentView.addSubview(topTabbar)
        
        scrollView.frame = CGRect(x: 0, y: topTabbar.height, width: contentView.width, height: contentView.height-topTabbar.height)
        scrollView.contentSize = CGSize(width: 0, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clear
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        contentView.addSubview(scrollView)
        
        self.contentView.top = self.height
        self.backgroundView.alpha = 0
        
        addTableView(withIndex: 0, animated: false)
    }
    
    private func addressDatas(withIndex index : Int) -> [AddressModel]? {
        if index == 0 {
            return self.dataSource
        }
        var array = self.dataSource
        for i in 1 ... index {
            array = array?[selectIndexs[i-1]].children
        }
        return array
    }

    private func addTableView(withIndex index :Int, animated :Bool) {

        for view in scrollView.subviews {
            if(view.tag >= index) {
                view.removeFromSuperview()
            }
        }
        
        let tableView = UITableView(frame: CGRect(x: CGFloat(index) * scrollView.width, y: 0, width: scrollView.width, height: scrollView.height),
                                    style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tag = index
        tableView.backgroundColor = UIColor.white
        tableView.register(AddressSelectCell.self, forCellReuseIdentifier: "AddressSelectCell\(index+1)")
        scrollView.addSubview(tableView)
        scrollView.contentSize = CGSize(width: CGFloat(index+1) * scrollView.width, height: scrollView.height)
        scrollView.setContentOffset(CGPoint(x: CGFloat(index)*self.scrollView.width, y: 0), animated: animated)
    }
    
    private func show() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 5.0,
                       options: .beginFromCurrentState,
                       animations: {
                        self.contentView.top = self.height - kAddressContentViewHeight
                        self.backgroundView.alpha = 0.7
        }) { (finished: Bool) in
            
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 5.0,
                       options: .beginFromCurrentState,
                       animations: {
                        self.contentView.top = self.height
                        self.backgroundView.alpha = 0
        }) { (finished: Bool) in
            self.removeFromSuperview()
        }
    }
    
    private func setAddress(withProvince provinceId: String?, city cityId: String?, district districtId: String?) {
        
        guard provinceId != nil && cityId != nil && districtId != nil else {
            return
        }
        
        guard !provinceId!.isEmpty && !cityId!.isEmpty && !districtId!.isEmpty else {
            return
        }
        
        selectIndexs = [Int]()
        let selectAddresss = [provinceId,cityId,districtId]
        var array = self.dataSource
        
        for addressId in selectAddresss {
            for (index, model) in array!.enumerated() {
                if model.region_id == addressId {
                    selectIndexs.append(index)
                    array = model.children
                    break;
                }
            }
        }
        
        for (index, model) in selectIndexs.enumerated() {
            self.addTableView(withIndex: index, animated: false)
            let model = addressDatas(withIndex: index)![model]
            self.topTabbar.addItem(withIndex: index, atAddress: model)
        }
    }
    
    @objc public class func show(withProvince province: String?, city: String?, district: String?, withSelectBlock block: @escaping SelectBlock) {
        
        let superView = UIApplication.shared.keyWindow!
        let addressView = AddressSelectView()
        superView.addSubview(addressView)
        addressView.selectBlock = block
        addressView.show()
        addressView.setAddress(withProvince: province, city: city, district: district)
    }
}

// MARK: - @protocol AddressSelectTopTabbarDelegate
extension AddressSelectView : AddressSelectTopTabbarDelegate {
    
    func topTabbar(_ topTabbar: AddressSelectTopTabbar, didSelectWithIndex index: Int) {
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.width*CGFloat(index), y: 0), animated: true)
    }
    
    func didSelelctCancel(_ topTabbar: AddressSelectTopTabbar) {
        hide()
    }
}

// MARK: - @protocol UIScrollViewDelegate
extension AddressSelectView: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == self.scrollView) {
            self.topTabbar.select(withIndex: Int(scrollView.contentOffset.x/self.scrollView.width))
        }
    }
}

// MARK: - @protocol UITableViewDelegate
extension AddressSelectView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if self.selectIndexs.count > tableView.tag {
            self.selectIndexs.removeLast(self.selectIndexs.count-tableView.tag)
        }
        self.selectIndexs.append(indexPath.row)
        
        if tableView.tag < 2 {
            
            let model = addressDatas(withIndex: tableView.tag)![indexPath.row]
            self.topTabbar.addItem(withIndex: tableView.tag, atAddress: model)
            self.addTableView(withIndex: tableView.tag+1, animated: true)
            tableView.reloadData()
            
        }else{
            
            let index1 = self.selectIndexs[0]
            let index2 = self.selectIndexs[1]
            let index3 = self.selectIndexs[2]
            
            let model1 = self.dataSource![index1]
            let model2 = model1.children![index2]
            let model3 = model2.children![index3]
            
            if selectBlock != nil {
                self.selectBlock!(model1, model2, model3)
            }
            hide()
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kAddressSelectCellHeight
    }
}

// MARK: - @protocol UITableViewDataSource
extension AddressSelectView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressSelectCell\(tableView.tag+1)", for: indexPath) as! AddressSelectCell
        let model = addressDatas(withIndex: tableView.tag)![indexPath.row]
        cell.titleLabel.text = model.region_name
        if selectIndexs.count > tableView.tag{
            let selectIndex = selectIndexs[tableView.tag]
            cell.isSelct(isSelect: selectIndex == indexPath.row)
        }else {
            cell.isSelct(isSelect: false)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableData =  addressDatas(withIndex: tableView.tag) {
            return tableData.count
        }
        return 0
    }
}



// MARK: - AddressConfigManager
class AddressConfigManager {
    
    public static let shared = AddressConfigManager()
    var addressDatas : AddressModels?
    init() {
        let jsonData = NSData(named: "area.json")! as Data
        addressDatas = AddressModels.model(withJSON:jsonData)
    }
}


// MARK: - AddressModel
class AddressModel : NSObject {
    
    @objc var region_id : String?
    @objc var region_name : String?
    @objc var children : [AddressModel]?

    @objc class func modelContainerPropertyGenericClass() -> [String:Any] {
        return ["children":AddressModel.self]
    }
}


// MARK: - AddressModels
class AddressModels :NSObject {
    
    @objc var items : [AddressModel]?
    
    @objc class func modelContainerPropertyGenericClass() -> [String:Any] {
        return ["items":AddressModel.self]
    }
}
