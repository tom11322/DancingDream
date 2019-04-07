//
//  ChatViewController.swift
//  Dancing Dream
//
//  Created by Wade Li on 4/7/19.
//  Copyright © 2019 Wade Li. All rights reserved.
//

import UIKit
import MessageInputBar
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageInputBarDelegate {
    
    var posts = [PFObject]()
    let commentB = MessageInputBar()
    var showsCB = false
    var selectedP: PFObject!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 5
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableV.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        let comment = comments[indexPath.row - 1]
        cell.contextF.text = comment["text"] as? String
        let user = comment["author"] as! PFUser
        cell.nameF.text = user.username
        return cell
    }
    
    @IBOutlet weak var tableV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentB.inputTextView.placeholder = "Add a comment..."
        commentB.sendButton.title = "Post"
        commentB.delegate = self
        tableV.delegate = self
        tableV.dataSource = self
        tableV.keyboardDismissMode = .interactive
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentB.inputTextView.text = nil
        showsCB = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentB
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCB
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedP
        comment["author"] = PFUser.current()!
        selectedP.add(comment, forKey: "comments")
        selectedP.saveInBackground { (success, error) in
            if success {
                print("Comment saved")
            }
            else {
                print("Error saving comment")
            }
        }
        tableV.reloadData()
        commentB.inputTextView.text = nil
        showsCB = false
        becomeFirstResponder()
        commentB.inputTextView.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
