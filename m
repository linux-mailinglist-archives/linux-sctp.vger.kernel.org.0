Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0970A42C
	for <lists+linux-sctp@lfdr.de>; Sat, 20 May 2023 03:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjETBJE (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 19 May 2023 21:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETBJD (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 19 May 2023 21:09:03 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144721A5
        for <linux-sctp@vger.kernel.org>; Fri, 19 May 2023 18:09:03 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55239f43426so1884477eaf.1
        for <linux-sctp@vger.kernel.org>; Fri, 19 May 2023 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684544942; x=1687136942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAepxyFptOWOAjz5QSjurwpievOyYxChWL553Z1SwQA=;
        b=PC5FJzP72j6Lbgmy161KR9D7OmEirVrj/DOGThg0ICH+KnKbpiMPxcfRwG1Xy+stdX
         3oMtDc4o5H956G4b8GNk/CA2gk0t0iIS/tZqZV4QBs9XR5TiLWJbPt2pwtI1ybYKM3lv
         8gu/iKo+0xR+H9M6Rp6afBDA+qZKOoIHmrJEfNhRZvdp1ZK7eoOTfzQE1iV+fO7jCy7O
         cpf46Ouv5KiA81wvekh79TmpTtr1yaGMFeoOAto77Is3/lONPiylz/KS2av+FnlTHEUj
         T5d0KRTcmoq2Oz98AP5dTqqKwC6O0nTcdmZlYtVLtf+eTPKZfkvGpwh4iItvdrcE02Ib
         H9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684544942; x=1687136942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAepxyFptOWOAjz5QSjurwpievOyYxChWL553Z1SwQA=;
        b=RnZZ1jEDQLs6ITIQiLbvXUWOWtGCLRyH2FEA9+iK+r+z0Ej8j3KthbJauli96jKaGc
         nlJtT/EprmD8bWndfYWXKhd0V/d5cH7t8UwyAvvoeoFPB7HN10an476Q6lIZX13wf7PN
         RuvI1fNq+RomI3UIUPxulc+jiwnCCKVdVAojc+7vO+V/v4U2wT86NNf+Yzz+NjPOZFs1
         LfkbCMwsEO2pd5+VI4OyaH4Yqy9kx7eYWWmrS/0Dr/qpPKGFj04WYb/YuCCqVFbHjBk9
         UVroEtFXmhZr/y3Ua2W/7bgu0dKhH44z7aaAN0qWGLifT/MOk+E6szj/jIh6LefjYvPg
         OY6g==
X-Gm-Message-State: AC+VfDy7vCa/KukraWATjE4L7EwXYV+7JPWXDiZ0Oz/7TbyHsfv4CS4x
        q1OTplktc5shqVNxq6nymxE=
X-Google-Smtp-Source: ACHHUZ5CuN3husae8NCdXoqPo8dxadDs+SObL+DSMTZlv+u8WBST61m0Ii0IQpXj69tmv+VCLItSNQ==
X-Received: by 2002:a4a:9c50:0:b0:54f:b59c:256a with SMTP id c16-20020a4a9c50000000b0054fb59c256amr1702434ook.4.1684544942273;
        Fri, 19 May 2023 18:09:02 -0700 (PDT)
Received: from t14s.localdomain ([2001:1284:f013:7b6f:cde:8bac:b418:261c])
        by smtp.gmail.com with ESMTPSA id y139-20020a4a4591000000b00541fbbbcd31sm292685ooa.5.2023.05.19.18.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 18:09:01 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 2593D6181CD; Fri, 19 May 2023 22:08:59 -0300 (-03)
Date:   Fri, 19 May 2023 22:08:59 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Adam Snaider <adam.snaider@bluerivertech.com>
Cc:     linux-sctp@vger.kernel.org, Xin Long <lucien.xin@gmail.com>
Subject: Re: SCTP Authentication Current State and Examples
Message-ID: <gthfvvjti4fz3z67373utythbfe5yxxhhayofbzusahy7ii4oq@drabuyrfycig>
References: <CALP-OgmKKFb4gMH0L6WYsxonBLDHbFHgpbc1=QY1N9HnFctWxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALP-OgmKKFb4gMH0L6WYsxonBLDHbFHgpbc1=QY1N9HnFctWxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, May 15, 2023 at 12:00:00PM -0700, Adam Snaider wrote:
> Hi folks,
> 
> I would like to ask what the current state is for SCTP Authentication
> in the Linux kernel (as described by rfc4895). I've been attempting to
> use an SCTP authenticated socket in the 5.10 kernel but all my efforts
> are fruitless so far. Given the lack of examples around, I'm not sure
> if my setup is incorrect or if the linux implementation is incomplete.
> If there are any references or examples I can look at I would really
> appreciate it.

Hi Adam,

The support should be complete, but yeah, I am not aware of examples
with Auth. Would you mind sharing a minimal reproducer that didn't
work for you?

Thanks,
Marcelo
