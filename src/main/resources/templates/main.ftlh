<#import "parts/common.ftlh" as c>
<#import "parts/messageEdit.ftlh" as editor>

<@c.page>
    <div class="form-row mb-3">
        <form method="get" action="/main" class="form-inline d-flex flex-row">
            <input type="text" class="form-control w-25 me-2"
                   name="filter" placeholder="Search by tag" value="${filter?if_exists}">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <@editor.messageForm true/>
    <#include "parts/messageList.ftlh">
</@c.page>
