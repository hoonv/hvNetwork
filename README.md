# hvNetwork

### usage

- dataTask
  ``` swift 
          HVNetwork.shared.dataTask(url, method: .get, task: .request) { 
          (result: Result<StoreItemResponse,NetworkError>) in
            switch result {
            case .success(let model):
                completion(model.body)
            case .failure(let error):
                print(error)
            }
        }
      
  ```
