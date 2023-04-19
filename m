Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3796E7E4E
	for <lists+linux-sctp@lfdr.de>; Wed, 19 Apr 2023 17:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjDSPbd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 19 Apr 2023 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjDSPbb (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 19 Apr 2023 11:31:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1C3AAA
        for <linux-sctp@vger.kernel.org>; Wed, 19 Apr 2023 08:31:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a92369761cso734815ad.3
        for <linux-sctp@vger.kernel.org>; Wed, 19 Apr 2023 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1681918287; x=1684510287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWNFIKn7SRRd/10Gz2AxxCEIVDzTsvNCmu9Y2KI0jk0=;
        b=H+rp0KhCc9amg67w1gw3zfc8qquYCPA59WWTG6rFFS+8bl5V4VJEkwGoiTgwRkqOh2
         r+01l5TO1+gN8cnbyaAL9b24v4zxJ5SXaZFzi9EZQ3mpCvrP2ClJdRYqD5ffGBt6Q82s
         VpMqtC6ksgvgN3gRMCainYWhyQJdixqGk8SipxxOi1GcSmgwJFD4/sALuEVrnf0JmMcV
         gygXIaYOAHJgnsdj5Sv68V4YqhFbnqshowOp91UmZgB/Id7Y0MktDaSOWBQHXAAtFSx6
         /ip8C9WwKtN40vJPDKcZusztpTfRvwF12vVJjGU/2eoFXAQ6bes2sFdCyuMzFObnlklJ
         wCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681918287; x=1684510287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWNFIKn7SRRd/10Gz2AxxCEIVDzTsvNCmu9Y2KI0jk0=;
        b=jFJlcWPs0RS8VI0gZTivl2REK0wY4GlpUUuy2K+OiAT6tTgju8h6t1ZT5j3ZrfvcuV
         o4Nwevo6HWsrg7xbEmHMAGbichruj/OhCeXjecnIZdpwzyTUR8H58pGKWGZiMe4e5+Ox
         E13uawg/Wjm7oMJFD8i7lycYYffNqwre47/OcrUFeFvyKAJHxPW+CAgP4vNIppp4DVG6
         Z5ldwo8lHUUY3k9RRA9zQRbEdLRztOzU1jMkBPSOh+iki8v2ItyNHeT09GyPlVy3luOO
         OGFZPYf36XIKdvH9tuI0czbiwInQo4Oc1vtT+CzilhkMWKRC54oprrl2PolHyUaPLwMy
         492Q==
X-Gm-Message-State: AAQBX9fiFUeNp8Eta1Qrolz1fJmhqtDJsOu0khveXk1psXn2/g6JhwHb
        PoysBBvbl++K/yf4BqP8Jxfr6Q==
X-Google-Smtp-Source: AKy350ZaRcfGeKDrPwj8e7XG6HMk7yBHI8vsooXeAFwVIWNZYtSfRfSa6Zf6GohIT1OMzd+2cw1Q3Q==
X-Received: by 2002:a17:902:eccb:b0:1a9:1b4:9fe3 with SMTP id a11-20020a170902eccb00b001a901b49fe3mr2155503plh.19.1681918287606;
        Wed, 19 Apr 2023 08:31:27 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id iz10-20020a170902ef8a00b001a4fa2f7a23sm5596309plb.274.2023.04.19.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:31:27 -0700 (PDT)
Date:   Wed, 19 Apr 2023 08:31:25 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net-next 2/6] sctp: delete the nested flexible array
 skip
Message-ID: <20230419083125.308b8732@hermes.local>
In-Reply-To: <48a8d405dd4d81f7be75b7f39685e090867d858b.1681917361.git.lucien.xin@gmail.com>
References: <cover.1681917361.git.lucien.xin@gmail.com>
        <48a8d405dd4d81f7be75b7f39685e090867d858b.1681917361.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, 19 Apr 2023 11:16:29 -0400
Xin Long <lucien.xin@gmail.com> wrote:

> diff --git a/include/linux/sctp.h b/include/linux/sctp.h
> index 0ff36a2737a3..9815b801fec0 100644
> --- a/include/linux/sctp.h
> +++ b/include/linux/sctp.h
> @@ -603,7 +603,7 @@ struct sctp_fwdtsn_skip {
>  
>  struct sctp_fwdtsn_hdr {
>  	__be32 new_cum_tsn;
> -	struct sctp_fwdtsn_skip skip[];
> +	/* struct sctp_fwdtsn_skip skip[]; */
>  };
>  

Why leave the old structure in comments.
Remove unused code and data structures please.
