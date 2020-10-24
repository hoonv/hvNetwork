# hvNetwork

alamofire를 참조해서 사용방식을 비슷하게 구현한 네트워크 모듈


### usage
- data request 
  - get
  ``` swift
      hvNet.request(Constant.postURL, method: .get, parameter: data)
      .response(completionHandler: { (result: HVDataResponse<Data?>) in })
  ```
  - post
  ``` swift
      hvNet.request(Constant.postURL, method: .post, parameter: data)
      .response(completionHandler: { _ in })
  ```

- decodable request
``` swift
    hvNet.request(url).response {
        (result: HVDataResponse<StoreItemResponse>) in
        switch result {
        case .success(let model):
            completion(model)
        case .failure(let error):
            print(error)
        }
    }
```
