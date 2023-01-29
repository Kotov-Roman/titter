<#include "security.ftlh">

<div>
    <a class="btn btn-primary mb-1" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample"
       aria-expanded="false" aria-controls="collapseExample">
        Message editor
    </a>
    <div class="collapse <#if message??>show</#if>" id="collapseExample">
        <div class="form-row mb-3">
            <form class="row g-3" method="post" action="/user-messages/${currentUserId}" enctype="multipart/form-data">

                <div class="col-auto">
                    <input type="text" name="text" placeholder="write something"
                           value="<#if message??>${message.text}</#if>"
                           class="form-control ${(textError??)?string('is-invalid','')}">
                    <#if textError??>
                        <div class="invalid-feedback">
                            ${textError}
                        </div>
                    </#if>
                </div>

                <div class="col-auto">
                    <input type="text" name="tag" placeholder="tag"
                           class="form-control ${(tagError??)?string('is-invalid','')}"
                           value="<#if message??>${message.tag}</#if>">
                    <#if tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>

                <div class="col-auto">
                    <div class="custom-file">
                        <input type="file" name="file" class="form-control" id="customFile">
                    </div>
                </div>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<#--                if message in input?-->
                <#if message??>
                    <input type="hidden" name="id" value="${message.id}"/>
                </#if>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary">Save Message</button>
                </div>
            </form>
        </div>
    </div>
</div>
