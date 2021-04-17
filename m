Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A128362C81
	for <lists+linux-sctp@lfdr.de>; Sat, 17 Apr 2021 02:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhDQA4D (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 16 Apr 2021 20:56:03 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.12]:13816 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhDQA4D (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 16 Apr 2021 20:56:03 -0400
X-Greylist: delayed 1505 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2021 20:56:03 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id EC88A426D852E
        for <linux-sctp@vger.kernel.org>; Fri, 16 Apr 2021 19:07:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id XYUGlQQvkb8LyXYUGlWHQA; Fri, 16 Apr 2021 19:07:00 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8/SlxvbyGzFIuckVM50DnSkCrS8UJPZyny+A2QmFDJ4=; b=EvSTyCbSbAJUxGRI/E8hKx9EyC
        gj3ZGdEoDnKLBr/Re0Z3XX5YrXCisVzXjUdZCKppl6EEjKTbjXx2HNpUg0vDph782pRGNA5/IoByJ
        WB18S50L5vChhrTetywaMeZQ8HIJRcWlHvKpcPO2jfrOqQIGRrOEtyl3hADc5FHi/QH0im4v3/EYC
        7gzixI3Yin/HmWpGuVDR8G6y9fPOQdhBATjhgmxZoU5/mxniHfkI5HiAr692A6xEETv7N4CUtynQL
        MvNpbt0WBzGOt8rsvd8V2oBRIklC053GkS1ldg/4VzfU2CKhPMOpKLRslHTTo3lFp+mum8VFze424
        PzWKWTKQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:56954 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lXYUC-000HmB-Do; Fri, 16 Apr 2021 19:06:56 -0500
Subject: Re: [PATCH][next] sctp: Fix out-of-bounds warning in
 sctp_process_asconf_param()
To:     patchwork-bot+netdevbpf@kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, kuba@kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210416191236.GA589296@embeddedor>
 <161861761155.26880.11889736067176146088.git-patchwork-notify@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <8f37be96-04dd-f948-4913-54da6c4ae9b2@embeddedor.com>
Date:   Fri, 16 Apr 2021 19:07:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161861761155.26880.11889736067176146088.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lXYUC-000HmB-Do
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:56954
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dave,

On 4/16/21 19:00, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (refs/heads/master):
> 
> On Fri, 16 Apr 2021 14:12:36 -0500 you wrote:
>> Fix the following out-of-bounds warning:
>>
>> net/sctp/sm_make_chunk.c:3150:4: warning: 'memcpy' offset [17, 28] from the object at 'addr' is out of the bounds of referenced subobject 'v4' with type 'struct sockaddr_in' at offset 0 [-Warray-bounds]
>>
>> This helps with the ongoing efforts to globally enable -Warray-bounds
>> and get us closer to being able to tighten the FORTIFY_SOURCE routines
>> on memcpy().
>>
>> [...]
> 
> Here is the summary with links:
>   - [next] sctp: Fix out-of-bounds warning in sctp_process_asconf_param()
>     https://git.kernel.org/netdev/net-next/c/e5272ad4aab3

Thanks for this. Can you take these other two, as well, please?

https://lore.kernel.org/linux-hardening/20210416201540.GA593906@embeddedor/
https://lore.kernel.org/linux-hardening/20210416193151.GA591935@embeddedor/

Thanks!
--
Gustavo
