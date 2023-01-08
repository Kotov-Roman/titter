<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>

    <div>
        <@l.logout ""></@l.logout>
        <span><a href="/user">User list</a></span>
    </div>
    <div>
        <form method="post" action="/add" enctype="multipart/form-data">
            <input type="text" name="text" placeholder="write something">
            <input type="text" name="tag" placeholder="tag">
            <input type="file" name="file">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit">Add</button>
        </form>
    </div>
    <div>Messages list</div>
    <form method="get" action="/main">
        <input type="text" name="filter" placeholder="tag" value="${filter?if_exists}">
        <button type="submit">Find</button>
    </form>

    <#list messages as message>
        <div>
            <b>${message.id}</b>
            <span>${message.text}</span>
            <i>${message.tag}</i>
            <strong>${message.authorName}</strong>
            <div>
                <#if message.filename??>
                    <img src="/img/${message.filename}"/>
                </#if>
            </div>
        </div>
    <#else>No messages
    </#list>
</@c.page>
