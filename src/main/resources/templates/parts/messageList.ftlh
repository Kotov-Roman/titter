<#include "security.ftlh">

<div class="row row-cols-1 row-cols-md-4 g-4">
    <#list messages as message>
        <div class="col">
            <div class="card my-1 h-100">
                <#if message.filename??>
                    <img src="/img/${message.filename}" class="card-img-top"/>
                </#if>
                <div class="card-body">
                    <div class="d-flex flex-column mb-1">
                        <span>${message.text}</span>
                        <i class="mt-2">#${message.tag}</i>
                    </div>
                </div>
                <div class="card-footer">
                    <small class="text-muted">
                        <a href="/user-messages/${message.author.id}">${message.authorName}</a>
                        <#if message.author.id == currentUserId>
                            <a class="btn btn-primary"
                               href="/user-messages/${message.author.id}?message=${message.id}">
                                Edit
                            </a>
                        </#if>
                    </small>
                </div>
            </div>
        </div>
    <#else>
        <div class="col">
            <p>No messages</p>
        </div>
    </#list>
</div>