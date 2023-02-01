<#import "parts/common.ftlh" as c>

<@c.page>
    <div>
<#--"user" and "type" are populated under the hood of Spring cuz i didn't add them excplicitly to model-->
        <h3>${user.username}</h3>
    </div>
    <div>${type}</div>
    <div>
        <#list users as user>
            <ul class="list-group">
                <li class="list-group-item">
                    <a href="/user-messages/${user.id}">${user.username}</a>
                </li>
            </ul>
        </#list>
    </div>
</@c.page>
