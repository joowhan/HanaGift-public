<%--
  Created by IntelliJ IDEA.
  User: gimjuhwan
  Date: 8/22/24
  Time: 10:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div id="deleteModal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">삭제 확인</h5>
                <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                >
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>정말 삭제하시겠어요?</p>
            </div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-secondary"
                        data-dismiss="modal"
                >
                    취소
                </button>
                <button
                        type="button"
                        class="btn btn-danger"
                        id="confirmDelete"
                >
                    삭제
                </button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
