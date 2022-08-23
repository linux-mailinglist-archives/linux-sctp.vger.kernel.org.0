Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43CB59E6BF
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Aug 2022 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244374AbiHWQOa (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 Aug 2022 12:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbiHWQOC (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 Aug 2022 12:14:02 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0032829A
        for <linux-sctp@vger.kernel.org>; Tue, 23 Aug 2022 05:34:36 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11c5505dba2so16555888fac.13
        for <linux-sctp@vger.kernel.org>; Tue, 23 Aug 2022 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FdCKUBukkwwL10zUiQT2xCfXVEOBO5hcBq0sJ97yCkg=;
        b=DiEjUOy2kC/aWGNTY3GXJiqxZNYpsV3jOEARG6ENzed+OSEZ9SDnyJnvDXlZhnDkr8
         YZFHJoNsxQHR6kbsR75zLfDZjtVL6svJAxyNzgYk81GfUm7egUPTglSfBZH69BlnOd3t
         yLHOueZioGfj0cpVGerB77cPxw8W8CW8NZcCSI/cEgsx0wvChi2YqM/jRgGN/c5tAwAa
         UFSf6107RAn4kkPK0PZFyKGuKOWlcRr3oh1PCIeKso1atox92N+vySt8SaNxexDY+MHB
         awXzzQOOHhftxUn3yQYTgjIIew2tTaug3AqEYDPL9YnYOK7F4U3rV22Ti5jR+x/2YjpB
         GndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FdCKUBukkwwL10zUiQT2xCfXVEOBO5hcBq0sJ97yCkg=;
        b=VszVPhqjnLIjridmOuMRr68ibajyE5YCs348TJyETeBlDaM2QctCtDtpzEpwhLjJf7
         AUlLBiWOpGGU+jUQ1e1n2RdQWLCGSdloSrRIKLUtJil0bpBK/lKPQrp97TLv5x1bLoJO
         ZlkUHg26m4Yb1uMIn4GrHl2xPr/udAHkfyVUbg86Zu128ZMSHMnv9o9Yfm/eoY5Lk+bM
         8YIuF6H2VRTlB9eXFdCOLTphToHA8CmNdEWzrXeG6JYIko/UQOf8dSDjxsRbE8WHDgjf
         Dg9suXoFhZVXIpVjm1ru1yuYC712pW4jwQYnvvkoG2ukBKIVAsy3Rb/BpPYy8wvryWHv
         KOJQ==
X-Gm-Message-State: ACgBeo0EIr0eQrFp9ZpU1gA7y0LlA+ZTl0qsGWZtInqYlsdfYZfuZ27L
        heDFkg4FY07geOqiMi53rLg=
X-Google-Smtp-Source: AA6agR7ElxtwILCq6KY9o26/WjP0M6Vkd7VDH9jDL9gh/DP4wBz51YS9cDHSQn98iN8WqXPib/Pw0w==
X-Received: by 2002:a05:6870:f229:b0:114:25db:4000 with SMTP id t41-20020a056870f22900b0011425db4000mr1272632oao.246.1661258075625;
        Tue, 23 Aug 2022 05:34:35 -0700 (PDT)
Received: from t14s.localdomain ([2804:d59:bfd3:3300:f810:cb2c:3ec9:6038])
        by smtp.gmail.com with ESMTPSA id y39-20020a9d22aa000000b00636eeba9209sm3634348ota.52.2022.08.23.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:34:35 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 3BA0A39540B; Tue, 23 Aug 2022 09:34:27 -0300 (-03)
Date:   Tue, 23 Aug 2022 09:34:27 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Yuxuan Luo <luoyuxuan.carl@gmail.com>
Cc:     linux-sctp@vger.kernel.org, lucien.xin@gmail.com, yuluo@redhat.com
Subject: Re: [PATCH lksctp-tools 0/2] func_tests: Add test cases for
 interleaving and stream RE_CONFIG
Message-ID: <YwTJUyGJYVs0UMft@t14s.localdomain>
References: <20220805154351.27646-1-luoyuxuan.carl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154351.27646-1-luoyuxuan.carl@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Aug 05, 2022 at 11:43:50AM -0400, Yuxuan Luo wrote:
> Add two test cases for verifying the support
> for interleaving and re_config recently implemented in kernel.
> 
> Signed-off-by: Yuxuan Luo <luoyuxuan.carl@gmail.com>
> 

Applied. Thanks folks.

  Marcelo
