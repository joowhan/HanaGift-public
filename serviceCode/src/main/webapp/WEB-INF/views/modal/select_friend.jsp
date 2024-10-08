<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/30/24
  Time: 6:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- Modal -->
<div
        class="modal fade"
        id="friendModal"
        tabindex="-1"
        role="dialog"
        aria-labelledby="friendModalLabel"
        aria-hidden="true"
>
    <div
            class="modal-dialog modal-dialog-centered"
            role="document"
    >
        <div class="modal-content">
            <div class="modal-header">
                <h5
                        class="modal-title"
                        id="friendModalLabel"
                >
                    친구를 선택해주세요!
                </h5>
                <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                >
                                                    <span aria-hidden="true"
                                                    >&times;</span
                                                    >
                </button>
            </div>
            <div class="modal-body">
                <input
                        type="text"
                        id="friendSearchInput"
                        class="form-control"
                        placeholder="Search for friends..."
                />
                <div class="friend-list mt-3">
                    <c:forEach var="friend" items="${friends}">
                        <div class="friend-item" data-friend-id="${friend.friendId}" data-friend-name="${friend.friendName}" onclick="selectFriend(this)">
                            <img src="${pageContext.request.contextPath}/resources/images/profile2.png" alt="Friend Avatar" class="friend-avatar"/>
                            <div class="friend-info">
                                <p class="friend-name">${friend.friendName}</p>
                                <span class="status-indicator online">Online</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <script>
                    function selectFriend(element) {
                        $('.friend-item').removeClass('selected');
                        $(element).addClass('selected');
                    }
                </script>
            </div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-secondary"
                        data-dismiss="modal"
                >
                    닫기
                </button>
                <button
                        type="button"
                        class="btn btn-primary"
                        id="selectFriendBtn"
                >
                    선택
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // 선택 버튼 클릭 시 모달 창을 닫기
    document.getElementById("selectFriendBtn").addEventListener("click", function () {
        $('#friendModal').modal('hide');
    });
</script>
<!-- jQuery 및 Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
