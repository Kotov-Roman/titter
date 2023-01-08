<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
    User editor:
    <form action="/user" method="post">
        <label>
            <input type="text" name="username" value="${user.username}"/>
        </label>
        <#list roles as role>
            <div>
                <label>
                    <input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>

                    ${role}
                </label>
            </div>
        </#list>
        <input type="hidden" name="userId" value="${user.id}"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit">Save</button>
    </form>
</@c.page>
