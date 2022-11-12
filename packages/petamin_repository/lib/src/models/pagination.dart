class PaginationData {
  final int currentPage;
  final int itemsPerPage;
  final int totalItems;
  final int totalPages;

  PaginationData(this.currentPage, this.itemsPerPage, this.totalItems, this.totalPages);

  // Initialize the pagination data with default values
  const PaginationData.initial()
      : currentPage = 1,
        itemsPerPage = 10,
        totalItems = 0,
        totalPages = 0;
}
