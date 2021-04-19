Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF5364E5E
	for <lists+linux-sctp@lfdr.de>; Tue, 20 Apr 2021 01:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDSXBW (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 19 Apr 2021 19:01:22 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.101]:32488 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhDSXBV (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 19 Apr 2021 19:01:21 -0400
X-Greylist: delayed 1275 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 19:01:21 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id B4789C8965
        for <linux-sctp@vger.kernel.org>; Mon, 19 Apr 2021 17:39:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YcYHlHNoF1cHeYcYHlQGpx; Mon, 19 Apr 2021 17:39:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=88m1MQb2nNveKjfeKb79bNGZ2voroxXvoMgEm6bgprw=; b=g7pKP/aSBbJKOVhGvPUSDYGt1z
        x5CIfc9MDd5mpy6v+e0dpvHUQQy0wgjRHci109PAkczmw/ScGX1iMmWZt6ebPRwVh9OizeWTEwPdA
        RdcHlCxVz1g8/ymsKi9eclXhKgrOxhQweysiGG8vCqW4Io4llgCaHT/MdC2BVCmx4Y70TJICPpAW2
        KhwnaU4u9dvoeYG3d7MW02Np9yiOYnvDpVXjgFma8531A3oIB72QIXgCpickWBokWYFdqKWw1UKSi
        vhnjCptciG7OfBf9E1I+DZ/DkVnELinyLaCWWmpCREeaqDYb4WFUhToF/lWeYlFwfWD1hU6AD56Op
        U/S8MNAQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:46944 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lYcYD-003azP-5Z; Mon, 19 Apr 2021 17:39:29 -0500
Subject: Re: [PATCH][next] sctp: Fix out-of-bounds warning in
 sctp_process_asconf_param()
To:     David Miller <davem@davemloft.net>
Cc:     patchwork-bot+netdevbpf@kernel.org, gustavoars@kernel.org,
        vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, kuba@kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210416191236.GA589296@embeddedor>
 <161861761155.26880.11889736067176146088.git-patchwork-notify@kernel.org>
 <8f37be96-04dd-f948-4913-54da6c4ae9b2@embeddedor.com>
 <20210419.153405.1531590596849653615.davem@davemloft.net>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <db839548-0715-51b0-f9ba-5405a201567f@embeddedor.com>
Date:   Mon, 19 Apr 2021 17:39:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210419.153405.1531590596849653615.davem@davemloft.net>
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
X-Exim-ID: 1lYcYD-003azP-5Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:46944
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



On 4/19/21 17:34, David Miller wrote:

>> Thanks for this. Can you take these other two, as well, please?
>>
>> https://lore.kernel.org/linux-hardening/20210416201540.GA593906@embeddedor/
>> https://lore.kernel.org/linux-hardening/20210416193151.GA591935@embeddedor/
>>
> 
> Done.

Thanks, Dave!

--
Gustavo
