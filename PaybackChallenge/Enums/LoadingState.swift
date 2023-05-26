enum LoadingState<T: ViewModel> {
    case loading
    case success(T)
    case failure
}
