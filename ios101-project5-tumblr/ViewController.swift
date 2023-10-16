//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    
    private var posts: [Post] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("🍏 numberOfRowsInSection called with posts count: \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = posts[indexPath.row]
        
        if let photo = post.photos.first {
            let url = photo.originalSize.url
            Nuke.loadImage(with: url, into: cell.postImageView)
        }
        cell.summaryLabel.text = post.summary
        return cell
    }

    @IBOutlet weak var tableView: UITableView!
    
    // Initialize a UIRefreshControl
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        
        // Add the refresh control to the table view
        if #available(iOS 10.0, *) {
                    tableView.refreshControl = refreshControl
                } else {
                    tableView.addSubview(refreshControl)
                }
        
        // Configure Refresh Control and add to table view
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh for more post!")
        
        fetchPosts(from: apiUrls[currentApiIndex])
    }
    
    // Created an array of the api urls as strings
    private let apiUrls = [
        "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk",
            "https://api.tumblr.com/v2/blog/story.fund/posts/photo?api_key=Ltzu3a5LycCTjdLk4ZVmEVw2lU6tTruLZvob03u7HtzZSjtfO6"
        ]

    // Created a counter to track api index in the array
    private var currentApiIndex = 0
    
    // Changes to the next API url in the array and load new posts when the user pulls to refresh
    @objc private func refreshData(_ sender: Any) {
        currentApiIndex = (currentApiIndex + 1) % apiUrls.count
        let url = apiUrls[currentApiIndex]
        fetchPosts(from: url)
    }

    
    // Added a parameter for a string of url
    func fetchPosts(from urlString: String) {
        
        // Convert url string to a url object
        guard let url = URL(string: urlString) else {
                print("Error: \(urlString) is not a valid URL")
                return
            }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }

            guard let data = data else {
                print("❌ Data is NIL")
                return
            }

            do {
                let blog = try JSONDecoder().decode(Blog.self, from: data)

                DispatchQueue.main.async { [weak self] in
                    
                    //let posts = blog.response.posts
                    
                    // Shuffle the posts to get them in random order
                    let posts = blog.response.posts.shuffled()


                    print("✅ We got \(posts.count) posts!")
                    for post in posts {
                        print("🍏 Summary: \(post.summary)")
                    }
                    
                    self?.posts = posts
                    
                    // Reload the table view to display new data
                    self?.tableView.reloadData()
                    
                    // Simulate a delay (for instance, network request delay)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        // End refreshing
                        self?.refreshControl.endRefreshing()
                    }
                }

            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
    }
}
