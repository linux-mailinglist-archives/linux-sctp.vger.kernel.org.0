Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897152FC4DD
	for <lists+linux-sctp@lfdr.de>; Wed, 20 Jan 2021 00:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbhASXhA (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 Jan 2021 18:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbhASXf7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 19 Jan 2021 18:35:59 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E1C061575
        for <linux-sctp@vger.kernel.org>; Tue, 19 Jan 2021 15:35:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id o20so4901703pfu.0
        for <linux-sctp@vger.kernel.org>; Tue, 19 Jan 2021 15:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9yriIeABzvRqPZwPZE8XoIm4dyyxjjIHmDtEXdOpziw=;
        b=cur2Aed8J4yCDTk/+N0YzCwCVAY6hcegD67X5rDVs18VgUKnjKiGNZ9VB7QHFWSbvI
         Jbs4tfOEZ8vaORnJW9XcH9ATiS9uudOAbNM1hLNeeyKUUojvg4cim0UqRtlnq4K8xmHz
         NUNsXe77SmOBKF4j05FItX7B31YWI4tv4eSDy+SHgiYzhOd1LfJ/d6j1euUQisEvheKY
         XXqMRV1Yh/DG2q4jZpgzbTeQzO2u5fuQQootsvaINDPIrbsUifUYeqt2YYV9cMKi4cFn
         FPQLaCVr8IJSSYROeKbd6tUBM/sedZueQJd7CYda4cGeoUEVyyE6O/A630f/tgDKUiXh
         gQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9yriIeABzvRqPZwPZE8XoIm4dyyxjjIHmDtEXdOpziw=;
        b=LsjVr9gNEKqco/VL2mAfxVYxsh1IKCO+XhSuidHbw1zJFiaEnyhoyzdrW3n1IhBKtJ
         toBQ6UWty8EmWrqKT6szoG9rdFLPMzdY3F5tqGiCX246j42lAOJvb5sWOLKSIPD3O3eD
         A5s4Nkp5UPpuKBXbhf7VTc+WfHIubT+F9207mKjkHz2YMHRASWVrWhZjPEMnx+clFvq8
         NrC0fzJ2C1J4BFhNqs8ZUcUGVMG1PW/T2fpVtwOk5O6d96aSrJbw2mVZA3CGm778ZoHj
         Rb3Kj2o+I32+XNVGh73Fiv2EwfnI9vpU952HmCSjxwu+f34fuVjDZxoOu4Jow1BUjBC3
         f0JA==
X-Gm-Message-State: AOAM532+2PVcpBzpbQsfWXtG7CGrjbmvAYZNQmpO5ADYgCBqFOtJNBt3
        9MrJhdApNvX7JYub7Y55gnMASg==
X-Google-Smtp-Source: ABdhPJyDzrwOtXs5Wusab1hOr+Eh43N5vPEpEsZc19ka8zosde4Nvw3kWB4Za/eFHuhU/o/9XSlXXg==
X-Received: by 2002:a62:cd49:0:b029:1b5:4e48:6f1a with SMTP id o70-20020a62cd490000b02901b54e486f1amr6169328pfg.14.1611099317116;
        Tue, 19 Jan 2021 15:35:17 -0800 (PST)
Received: from Shannons-MacBook-Pro.local ([50.53.47.17])
        by smtp.gmail.com with ESMTPSA id w20sm161131pga.90.2021.01.19.15.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 15:35:16 -0800 (PST)
Subject: Re: [PATCH net-next 1/6] net: add inline function skb_csum_is_sctp
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
References: <cover.1610777159.git.lucien.xin@gmail.com>
 <34c9f5b8c31610687925d9db1f151d5bc87deba7.1610777159.git.lucien.xin@gmail.com>
 <CAKgT0UduX4M-N1Kyo-M2=05EO_rAs2c_CDrUwWMKk2oDOgxd2Q@mail.gmail.com>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <41658acb-6607-8b4c-d29d-f71892434e0b@pensando.io>
Date:   Tue, 19 Jan 2021 15:35:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAKgT0UduX4M-N1Kyo-M2=05EO_rAs2c_CDrUwWMKk2oDOgxd2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 1/19/21 2:23 PM, Alexander Duyck wrote:
> On Fri, Jan 15, 2021 at 10:13 PM Xin Long <lucien.xin@gmail.com> wrote:
>> This patch is to define a inline function skb_csum_is_sctp(), and
>> also replace all places where it checks if it's a SCTP CSUM skb.
>> This function would be used later in many networking drivers in
>> the following patches.
>>
>> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> One minor nit. If you had to resubmit this I might move the ionic
> driver code into a separate patch. However It can probably be accepted
> as is.
>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

Alex has a good point - if you repost, please split out the ionic bits 
to a separate patch.

Either way, for ionic:
Acked-by: Shannon Nelson <snelson@pensando.io>


>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
>>   include/linux/skbuff.h                           | 5 +++++
>>   net/core/dev.c                                   | 2 +-
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> index ac4cd5d..162a1ff 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
>> @@ -979,7 +979,7 @@ static int ionic_tx_calc_csum(struct ionic_queue *q, struct sk_buff *skb)
>>                  stats->vlan_inserted++;
>>          }
>>
>> -       if (skb->csum_not_inet)
>> +       if (skb_csum_is_sctp(skb))
>>                  stats->crc32_csum++;
>>          else
>>                  stats->csum++;
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index c9568cf..46f901a 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -4621,6 +4621,11 @@ static inline void skb_reset_redirect(struct sk_buff *skb)
>>   #endif
>>   }
>>
>> +static inline bool skb_csum_is_sctp(struct sk_buff *skb)
>> +{
>> +       return skb->csum_not_inet;
>> +}
>> +
>>   static inline void skb_set_kcov_handle(struct sk_buff *skb,
>>                                         const u64 kcov_handle)
>>   {
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 0a31d4e..bbd306f 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3617,7 +3617,7 @@ static struct sk_buff *validate_xmit_vlan(struct sk_buff *skb,
>>   int skb_csum_hwoffload_help(struct sk_buff *skb,
>>                              const netdev_features_t features)
>>   {
>> -       if (unlikely(skb->csum_not_inet))
>> +       if (unlikely(skb_csum_is_sctp(skb)))
>>                  return !!(features & NETIF_F_SCTP_CRC) ? 0 :
>>                          skb_crc32c_csum_help(skb);
>>
>> --
>> 2.1.0
>>

