Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B34A99F3
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Feb 2022 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356370AbiBDNaI (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 4 Feb 2022 08:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231856AbiBDNaI (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 4 Feb 2022 08:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643981407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+eNq5uaI/eASnAIqIcgutbuvU96IBWgXC/XrViu/lQ=;
        b=WEXSndmBk7xvdPsAS/lF64cTjdCqZmtb9X7zS6gGS0Z1Xh3q4kJ92yAigtmUbtF1/e1cud
        Torvpu4KLTNuq6PQkKzM7majEUNkEto6SEol2pdAPjojEsJX5c+wmegeo3ms4NxgV6BbRh
        /whEQjlfZYm6vPiKa/U2T8kiShq9EQM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-troV_kboN-6x9Ylu5jwngg-1; Fri, 04 Feb 2022 08:30:05 -0500
X-MC-Unique: troV_kboN-6x9Ylu5jwngg-1
Received: by mail-ua1-f72.google.com with SMTP id f26-20020ab074da000000b0030ffb0782f4so3540050uaq.4
        for <linux-sctp@vger.kernel.org>; Fri, 04 Feb 2022 05:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+eNq5uaI/eASnAIqIcgutbuvU96IBWgXC/XrViu/lQ=;
        b=ttiYBVbe3ZWiBhU2xbNtD84YUrxRCdQ4EUxbF6ApSjRIY03H4riu4/+divFEqbWLnB
         7MPIOF77khQad54xy4w88FljGuwUjmPQhnT19JYkXXPq05GR1ZbWMwj9XuBPGEZL+jIP
         T5GTZgZ1gkgsCAsyRpi7FDIxfL6wK6GVsULHkFkQpfzRDpf6AwncIKAoRt8wYF7f+gFl
         wcu3YTm1PNQ4+/Yu3Rqh4pU5ZBYLUHtXPVWuH8NO7MYUvHON2uHsqFjZedx5aFqTmN98
         2GUl/5STA5mGjQBOoDxPn4KfN9q4bPUSnFSrTSNc6CByH6T0RQc9NiabhZ8IrrzY0TIn
         4WSQ==
X-Gm-Message-State: AOAM532jMPU2HsrrEX26HDvJ07qbc57RwzWLkTbI6G8rWP2uV/KhSpUB
        aclan/5e6c/4sJ7DC+UOl2BngLRPqIfqvdztDmck3X+iMRXO/wzMo2rllM5VGwT8uByGk5cmrYX
        5BGSuMFaasKLkwxiUZxA4P0pyvx5BkEBUcLNkIw==
X-Received: by 2002:a05:6102:c11:: with SMTP id x17mr824413vss.57.1643981404802;
        Fri, 04 Feb 2022 05:30:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaKr50xKw+4RYig79nuurWVcWzvrtcIEHRT3ftuZe21sDmiYvpXNHX+qheh87skuSONWZyo8/Qk9HRRhef2b0=
X-Received: by 2002:a05:6102:c11:: with SMTP id x17mr824408vss.57.1643981404569;
 Fri, 04 Feb 2022 05:30:04 -0800 (PST)
MIME-Version: 1.0
References: <YfwVcwpZU/lusVlC@pevik>
In-Reply-To: <YfwVcwpZU/lusVlC@pevik>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Fri, 4 Feb 2022 14:29:01 +0100
Message-ID: <CA+tGwnk9YO+0Df_BRqjOU4W5y-TgdJNE3PdnaB5RWWLRF0=8cQ@mail.gmail.com>
Subject: Re: [Automated-testing] SCTP testing
To:     Petr Vorel <pvorel@suse.cz>
Cc:     automated-testing@lists.yoctoproject.org, ltp@lists.linux.it,
        linux-sctp@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkabatov@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Feb 3, 2022 at 6:51 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> we've been just discussing, which repository should be hosting SCTP tests [1].
>
> Do you use these SCTP tests? If yes, do you use it from LTP [2] or the official
> SCTP kernel developers repository [3] ? If you use integrated to some testing
> framework, would it be a problem if repository changes?
>
> Also, do you use LTP network tests at all?
>

Hi,

we're currently not running these, but if I may offer a suggestion from my
experience: It's easier for people to pick up testing when it's already a
part of a test suite, rather than a separate test that they have to figure
out a) even exists b) how to run it

There are large test suites like LTP, kselftests and xfstests that most
people are aware of, but then you get a lot of smaller tests or random
scripts that, unless you're already familiar with the subsystem or get
them linked directly, people won't find easily. And if a CI system wants
to start running those tests, they most likely need to create a wrapper
to handle test specifics, while the enablement via a larger test suite
is way easier (as they can already handle it and all that's needed is
to enable that specific test subset).

Consolidating smaller tests into LTP or kselftests, where applicable,
would make the testing process more streamlined and easier to follow
for new folks too, as the expected testing could be unified across
subsystems and there would be no surprises.


Veronika

> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/linux-sctp/YfpnVfrto4Elshy5@pevik/
> [2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
> [3] https://github.com/sctp/lksctp-tools
>

