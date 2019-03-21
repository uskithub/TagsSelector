//
//  ViewController.swift
//  TsgsSelector
//
//  Created by yusuke-tech on 03/20/2019.
//  Copyright (c) 2019 yusuke-tech. All rights reserved.
//

import UIKit
import TsgsSelector

let fruits = [ "アケビ","アボカド","アンズ","イチゴ","イチジク","ウメ","オレンジ","カキ","キョホウ","キンカン","クリ","サクランボ"    ,"ザクロ","スターフルーツ","スモモ","ナシ","パイナップル","ハッサク","バナナ","パパイア","ビワ","ブドウ","マンゴー","ミカン","メロン","モモ","ユズ","ライチ","リンゴ","レモン"]

class ViewController: UIViewController {
    
    @IBOutlet weak var tagBar: TSTagBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tagBar.tags = fruits.map { TSTag($0) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagBar.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

