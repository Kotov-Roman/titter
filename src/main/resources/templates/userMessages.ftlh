<#import "parts/common.ftlh" as c>
<#import "parts/messageEdit.ftlh" as editor>
<#import "parts/login.ftlh" as l>

<@c.page>
    <div>
        <h3>${userChannel.username}</h3>
    </div>
    <div class="mb-3">
        <#if !isCurrentUser>
            <#if isSubscriber>
                <a class="btn btn-info" href="/user/unsubscribe/${userChannel.id}">Unsubscribe</a>
            <#else >
                <a class="btn btn-info" href="/user/subscribe/${userChannel.id}">Subscribe</a>
            </#if>
        </#if>
    </div>

    <div class=" mb-3">
        <div class="d-flex flex-row">
            <div class="card  w-25">
                <div class="card-body">
                    <div class="card-title">
                        Subscriptions
                    </div>
                    <h3 class="card-text">
                        <a href="/user/subscriptions/${userChannel.id}/list">${subscriptionsCount}</a>
                    </h3>
                </div>
            </div>
            <div class="card mx-2 w-25">
                <div class="card-body">
                    <div class="card-title">
                        Subscribers
                    </div>
                    <h3 class="card-text">
                        <a href="/user/subscribers/${userChannel.id}/list">${subscribersCount}</a>
                    </h3>
                </div>
            </div>

        </div>
    </div>
    <#if isCurrentUser>
        <@editor.messageForm false/>
    </#if>
    <#include "parts/messageList.ftlh">
</@c.page>
