<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="form-row mb-3">
        <form method="get" action="/main" class="form-inline d-flex flex-row">
            <input type="text" class="form-control w-25 me-2"
                   name="filter" placeholder="Search by tag" value="${filter?if_exists}">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <#include "parts/messageEdit.ftlh">
    <#include "parts/messageList.ftlh">
</@c.page>
