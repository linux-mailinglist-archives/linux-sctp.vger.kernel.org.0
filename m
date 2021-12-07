Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D659446C264
	for <lists+linux-sctp@lfdr.de>; Tue,  7 Dec 2021 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhLGSMg (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 7 Dec 2021 13:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbhLGSMf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 7 Dec 2021 13:12:35 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B07C061574
        for <linux-sctp@vger.kernel.org>; Tue,  7 Dec 2021 10:09:05 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id l24so46489uak.2
        for <linux-sctp@vger.kernel.org>; Tue, 07 Dec 2021 10:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cCUM1lEbcBNYrD2ZSJos7dWypTScplKBKMOULp/u4X8=;
        b=SsbQqSts/JEje7pqUuNy7B3F2h/VylK9qxlas/k5xlHFx/9srKr/ruNLbZ8H4biHpH
         7rqB5grtbsLwFZlVfarQtq4cNYXX+y/JXmH6xbufWoKt/SRC+UTWDsGE3ce5W2y5pijw
         q/lNWqQ8QD07ra31aZjpT6dVRb18wNghu/AqL7HGE9mUy6czyNq4GtU0+X+TU1CaXBVi
         fXHktk+GI29NaX6WKBwZVPJ5XVsYKP4RQuvPX8qEFZxXj+Nx1H/9+DOsJchRK+Bu7r6F
         Ce5+nLm/HV2RwS0mrDfX8Pcn5yUv0HdSXw6CXQmfc86HQea5QOCyWpCvRjXy6fdkYQsD
         gZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cCUM1lEbcBNYrD2ZSJos7dWypTScplKBKMOULp/u4X8=;
        b=e+ErZwTDg24A9UnKAmoKKWbfU5cmdnO98qyoZWq7HeW0LkHppMlWNRwQiHEkbfTwUy
         elTaNXQalnbE90GE4+vfqhj7ZKqKU9A2kzdeSnNebpL6R0cAEUaZZCxRO2CjVrVUJxlT
         iAB3BCVyiHawCW+lPfXJXuc1lIaANqsFl7dOkSMzmTkzuf1XH8o03paRLr2C2iCrode7
         oWqMEN5kTwiG5U/CdZGh0TXMYfwMuTTM2VmRAvCk7VTE5y860tpLfwfxihJdi1/sKCgM
         UrrKGhlLobtLSqiLPMk3eve8jgKrfnSxvE7NmshY7J+9JkIUixCmgWQWIfOBmpjKM+eJ
         Ukgw==
X-Gm-Message-State: AOAM532A3OsHgVIHOrnbn2yZw+Vw/vJR/WzI6O2wrC9osP0J+b6GP5Ak
        vCUYL7DtCtuqBUn9zgilSmgySytF7WY=
X-Google-Smtp-Source: ABdhPJzFuReLPgOucfZjrOTqtiRMGsPvDxmppAgu7vEMDoWltWKfZZS7e8ng5gWRHGORDel9s2msjg==
X-Received: by 2002:a67:5fc6:: with SMTP id t189mr45552627vsb.79.1638900544183;
        Tue, 07 Dec 2021 10:09:04 -0800 (PST)
Received: from t14s.localdomain ([177.220.172.101])
        by smtp.gmail.com with ESMTPSA id y7sm243898uad.2.2021.12.07.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:09:03 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id C5D4DEC378; Tue,  7 Dec 2021 15:09:01 -0300 (-03)
Date:   Tue, 7 Dec 2021 15:09:01 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: [PATCH lksctp-tools] sctp_test: check strdup return in
 append_addr
Message-ID: <20211207180901.5xncbn23ijrnx5tk@t14s.localdomain>
References: <82e5a846ca8cedf06e36a83422b6cb51cb0be61b.1637769324.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e5a846ca8cedf06e36a83422b6cb51cb0be61b.1637769324.git.lucien.xin@gmail.com>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Nov 24, 2021 at 10:55:24AM -0500, Xin Long wrote:
> strdup() may return NULL in append_addr(), and we should do the
> check for its return value before operating it.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Applied. Thanks.
