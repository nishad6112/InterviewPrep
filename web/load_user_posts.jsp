
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>


<div class="row">
    <%
        
        User uuu=(User)session.getAttribute("currentUser");
        
       // Thread.sleep(10);
        PostDao d = new PostDao(ConnectionProvider.getConnection());
         int cid = Integer.parseInt(request.getParameter("cid"));
         int postid = Integer.parseInt(request.getParameter("postid"));
         List<Post> userposts=null;
//         List<Post> userCatPosts=null;
//         userposts = d.getPostByUserId(uid);
//         userCatPosts = d.getUserPostByCatId(cid, uid);
          // Delete post query and response
           int responseData=d.deletePostByPostId(postid);
          // out.print(responseData); 
         if (cid == 0) {
            userposts = d.getPostByUserId(uuu.getId());
        } else {
            userposts = d.getUserPostByCatId(cid, uuu.getId());
        }
        
        if (userposts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
            return;
        }
//        if(userposts.size() == 0) {
//            out.println("<h3 class='display-3 text-center'>You haven't Posted yet !!</h3>");
//            return;
//        }
//         if(userCatPosts.size() == 0) {
//            out.println("<h3 class='display-3 text-center'>You haven't Posted anything in this category!!</h3>");
//            return;
//        }
        
        for (Post u : userposts) {
    
    
    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%= u.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%= u.getpTitle()%></b>
                <p><%= u.getpContent()%></p>

            </div>
            <div class="card-footer primary-background text-center">
                <% 
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                %>

                <a href="#!" onclick="doLike(<%= u.getPid()%>,<%= uuu.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(u.getPid())%></span>  </a>

                <a href="show_user_blog_page.jsp?post_id=<%= u.getPid()%>" class="btn btn-outline-light btn-sm">Read More...</a>
                <a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-commenting-o"></i> <span>20</span>  </a>
            </div>

        </div>


    </div>
 <%
        }
 %>
</div>
    
 